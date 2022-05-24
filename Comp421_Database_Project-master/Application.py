import sys,os,re
import psycopg2
import datetime
import random
####################### READ ME #########################################
# GROUP 60 application deliverable: 
#
# Install psycopg2 libraries to run
# For more implementation details of psycopg2: http://initd.org/psycopg/docs/
#
# Note, the UI program calls os.system('clear') which is Linux specific. 
# We're not sure what running this on a windows machine will do. 
#
#########################################################################
#
# CURRENT STATUS: Finished
#
#########################################################################

# Globals:
valid_numerical = re.compile('\d+')

# Methods:

#Needed for correct parsing of comments 
class CommentTree():

	#basic tree structure
	
	def __init__(self, node, depth, content):
		self.node = node 
		self.children = []
		self.depth = depth
		self.content = content
		
	def add_child(self, newNode,content):
		self.children.append(CommentTree(newNode,self.depth+1,content)) 
		
	def insertNode(self,parent,child,content):
		found = False
		if self.node == parent:
			self.add_child(child,content)
			found = True
		else:
			for c in self.children:
				if c.insertNode(parent,child,content):
					found = True
		return found
	
	# Needed for correct printing, displays comments in a preordered tree structure
	def preorderPrinting(self):
		if self.node != None:
			space = self.depth-1
			print '\t'*space + ' [%s] | %s'% (self.node,self.content[0])
			print '\t'*space + '     |\t- Comment by %s on %s'%(self.content[1],self.content[2])
			print '\t'*space + '     |\n'
		for c in self.children:
			c.preorderPrinting()

# Generation of unique submission ID's
def generate_SID(cur):
	query = '''SELECT sid FROM submissions'''
	cur.execute(query)
	rows = cur.fetchall()
	rows = [r[0] for r in rows] 
	sid = random.choice(range(0,1000000))
	while sid in rows:
		sid = random.choice(range(0,1000000))
	return sid

# Basic login menu, allows users to create new users or login
def gui_Login(cur,state):
	prompt = '''
----------------------------------------------------------
	 Welcome to Feddit, the frontpage of COMP 421!
----------------------------------------------------------
	[a] Login
	[b] Create User
	[q] Quit 
	
Select Option: '''
	inp = raw_input(prompt)
	cur.execute('''SELECT username FROM users;''')
	rows = cur.fetchall()
	registered_Usernames = [r[0] for r in rows] 
	try:
	
		#
		# Login with a username
		#
		if inp == 'a':
			prompt = 'Please input a valid usename (Note, usernames are CaSe Sensitive): '
			input_Username = raw_input(prompt)
			if input_Username in registered_Usernames:
				print '\n\tLogging In ...\n'
				state['state'] = 'mainmenu'
				state['username'] = input_Username
			else:
				state['error'] = '\n\tUser not found\n'
				
		#
		# Create user (NEED TO IMPLEMENT THIS)
		#
		elif inp == 'b':
			input_Username = raw_input('\nEnter a new username: ')
			if input_Username in registered_Usernames:
				state['error'] = 'Username already exists'
			else:
				email = raw_input('Enter an email: ')
				country = raw_input('Enter your home country: ')
				cur.execute('INSERT INTO users VALUES(%s,%s,%s,%s,%s,%s,%s);',(input_Username,email,0,datetime.date.today(),country,True,False))
				state['error'] = '\n\tUser created sucessfully\n'
			
		#	
		# quit application
		#
		elif inp == 'q':
			state['state'] = 'quit'
		else:
			state['error'] = 'Command not recognized!'
	except psycopg2.Error as e:
		state['error'] = e.pgerror
		
	return state

#Main menu gui and options
def gui_MainMenu(cur,state):
	print '''----------------------------------------------------------
	Welcome %s!
	| MAIN MENU |\n----------------------------------------------------------'''%state['username']
	prompt = '''
	[a] Goto board
	[b] Create board
	[c] Logout
	[q] Quit
	
Select Option: '''
	inp = raw_input(prompt)
	try:
		
		#
		# Goto board
		#
		if inp == 'a':
			prompt = 'Please type in a valid board name or board URL: '
			query = '''SELECT board_url,board_name FROM boards'''
			cur.execute(query)
			rows = cur.fetchall()
			board_URL_Input = raw_input(prompt)
			found = 0
			#search through query
			for r in rows:
				if board_URL_Input in r:
					state['state'] = 'board'
					state['board'] = r[0] #id is the board url
					found = 1 
					break
			if found == 0:
				state['error'] = '\n\tBoard not found, try again!\n' 
				
		#
		# Board creation
		#
		
		elif inp == 'b':
			boardname = raw_input('\nPlease enter a board name: ')
			description = raw_input('Please enter a description of the board: ')
			cur.execute('INSERT INTO boards VALUES(%s,%s,%s,%s,%s)',('www.feddit.com/boards/%s'%(boardname),boardname,0,description,state['username']))
			state['error'] = '\nBoard creation successful\n'
			
		# Back to login and quit
		elif inp == 'c':
			state['state'] = 'login'
			state['board'] = None
			state['username'] = None
		elif inp == 'q':
			state['state'] = 'quit'
		else:
			state['error'] = 'Command not recognized'
	except psycopg2.Error as e:
		state['error'] = e.pgerror
		
	return state
	
def gui_Board(cur,state):
	
	#
	#Getting board information
	#
	
	try: 
		board_name = state['board']
		cur.execute( '''SELECT *
						FROM boards b
						WHERE b.board_url = %s ''', (board_name,))
		rows = cur.fetchall()
		print '''
----------------------------------------------------------
	| %s | Subscribers: %d Owner: %s
----------------------------------------------------------
 %s
----------------------------------------------------------''' % (rows[0][1],rows[0][2],rows[0][4],rows[0][3])
		
		#
		#getting all posts
		#

		cur.execute('''SELECT post_title,date,username,s.sid
						FROM posts p JOIN submissions s
						ON s.sid = p.sid AND p.board_url = %s
						ORDER BY(s.date) DESC''',(state['board'],))
		rows = cur.fetchall()
		num_Posts = len(rows)
		for i in range(len(rows)):
			print '''--- --- --- --- --- ---- --- --- ---- --- --- --- --- ---
 [%d] %s
 Posted by %s on %s''' %(i,rows[i][0],rows[i][2],rows[i][1].isoformat())
		print '--- --- --- --- --- ---- --- --- ---- --- --- --- --- ---'
		#
		# Menu options: 
		#
		
		if num_Posts == 0:
			opt = 'None'
		else:
			opt = str(num_Posts-1)

		prompt = '''
	[0-%s] View post
	[a] Create Post
	[b] Back
		
Select Option: ''' %(opt)

		global valid_numerical
		inp = raw_input(prompt)
		if valid_numerical.match(inp) and int(inp) >= 0 and int(inp) < num_Posts:
			state['state'] = 'post'
			state['post'] = rows[int(inp)][3]
		#
		# Inserting post into the board
		#
		elif inp == 'a':
			title = raw_input("Enter a post title: ")
			content = raw_input("Enter post content: ")
			sid = generate_SID(cur)
			#Calling stored proceedure
			cur.callproc('post',(sid,title,content,state['username'],state['board'],datetime.date.today()))
		elif inp == 'b':
			state['state'] = 'mainmenu'
			state['board'] = None
		else:
			state['error'] = 'Command not recognized!'
	except psycopg2.Error as e:
		state['error'] = e.pgerror
	return state

#
# Post gui
#
def gui_Post(cur,state):
	try:
		#finding post information
		cur.execute('''SELECT post_title,post_content,date,username,s.sid
						FROM posts p JOIN submissions s
						ON s.sid = p.sid AND p.sid = %s
						''',(state['post'],))
		rows = cur.fetchall()
		print 'Viewing post on %s\n' % (user_State['board'])
		print '''----------------------------------------------------------
%s
----------------------------------------------------------
--- --- --- --- --- ---- --- --- ---- --- --- --- --- ---
%s
--- --- --- --- --- ---- --- --- ---- --- --- --- --- ---
Posted by %s on %s\n''' % (rows[0][0],rows[0][1],rows[0][3],rows[0][2])
		
		#
		# Comment rendering
		#
		print 'Comments: '
		#gets all comments and parent comments if they exist
		cur.execute('''
		SELECT Bcc.sid,Bcc.sid_parent,Bcc.comment_content,s.username,s.date
		FROM submissions s JOIN(
			SELECT *
				FROM 	(
					SELECT *
					FROM comments c 
					WHERE c.pid = %s
					) as B
				LEFT OUTER JOIN comment_chain cc
				ON cc.sid_child = B.sid
			) as Bcc
		ON Bcc.sid = s.sid;
		''',(state['post'],))
		rows = cur.fetchall()	
		root = CommentTree(None,0,None)
		map = {'forward':{None:None},'reverse':{None:None}}
		count = 0
		for r in rows:
			map['reverse'].update({str(count):r[0]})
			map['forward'].update({r[0]:str(count)})
			count += 1
		while rows:
			for r in rows:
				if root.insertNode(map['forward'][r[1]],map['forward'][r[0]],(r[2:])):
					rows.remove(r)
					
		root.preorderPrinting()
		
		
		#
		# Input parsing
		#
		if count == 0:
			opt = 'None'
		else:
			opt = str(count-1)
		prompt = '''
		
	[0-%s] Reply to comment
	[a] Create new comment
	[b] Back 
	
Select option: ''' %(opt)
		inp = raw_input(prompt)
		global valid_numerical
		
		#
		# New comment
		#
		if inp == 'a':
			comment = raw_input('Reply to post: ')
			sid = generate_SID(cur)
			cur.execute('''
			INSERT INTO submissions VALUES(%s,true,%s,%s);
			INSERT INTO comments VALUES(%s,%s,%s);
			''',(sid,datetime.date.today(),state['username'],
				sid,state['post'],comment))
				
		elif inp == 'b':
			state['state'] = 'board'
			state['post'] = None
			
		#
		# Reply to comment
		#
		elif valid_numerical.match(inp) and int(inp) >= 0 and int(inp) < count:
			comment = raw_input('Reply to comment: ')
			sid = generate_SID(cur)
			cur.execute('''
			INSERT INTO submissions VALUES(%s,true,%s,%s);
			INSERT INTO comments VALUES(%s,%s,%s);
			INSERT INTO comment_chain VALUES(%s,%s);
			''',(sid,datetime.date.today(),state['username'],
				sid,state['post'],comment,
				map['reverse'][inp],sid))
		else:
			state['error'] = 'Command not recognized\n'
			
	except psycopg2.Error as e:
		state['error'] = e.pgerror
		state['state'] = 'quit'
	
	return state

# Main
if __name__ == '__main__':
	
	#
	# Database connection
	#
	
	try:
		db_conn = psycopg2.connect("dbname='' user='' host='' password=''")
		print 'Successful connection to database'
	except psycopg2.Error as e:
		print 'Unable to connect to database'
		print e.diag.message_primary
		sys.exit(1)
	# Cursor instantiation
	cur = db_conn.cursor()

	# State initialization
	user_State = {'state':'login','board':None,'post':None,'username':None,'error':None}	
	
	#
	# Main application loop
	#	

	app_Running = True
	while(app_Running):
		os.system('clear')
		
		#Displaying error codes
		if user_State['error'] != None:
			print user_State['error']
			user_State['error'] = None
			
		#States
		if user_State['state'] == 'login':
			state_Stack = []
			user_State = gui_Login(cur,user_State)
		elif user_State['state'] == 'mainmenu':
			user_State = gui_MainMenu(cur,user_State)
		elif user_State['state'] == 'board':
			user_State = gui_Board(cur,user_State)
		elif user_State['state'] == 'post':
			user_State = gui_Post(cur,user_State)
		elif user_State['state'] == 'quit':
			app_Running = False
		else:
			print 'ERROR, current state not recognized, closing application (How the heck did you get here???)'
			app_Running = False
		
		#UNCOMMENT IF YOU WANT TO COMMIT CHANGES
		db_conn.commit()
	#
	# End program
	#

	cur.close()
	db_conn.close()

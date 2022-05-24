CREATE TABLE users(
   username VARCHAR(50) NOT NULL CONSTRAINT user_key PRIMARY KEY
  ,email VARCHAR(50)
  ,score INTEGER
  ,join_date VARCHAR(10)
  ,country VARCHAR(50)
  ,status BOOLEAN
  ,sadmin BOOLEAN
);

-- BOARDS AND SUBMISSIONS TABLES --
CREATE TABLE boards(
  board_url varchar(255) CONSTRAINT boards_key PRIMARY KEY
 ,board_name varchar(255)
 ,num_subs integer
 ,desc_rules text
 ,owner varchar(50) CONSTRAINT boards_user_key references users(username)
 );
 
CREATE TABLE submissions(
   sid integer CONSTRAINT sub_key PRIMARY KEY
  ,status boolean
  ,date timestamp
  ,username varchar(50) CONSTRAINT submissions_user_key references users(username)
 );

 
CREATE TABLE posts(
	sid integer PRIMARY KEY
  ,board_url varchar(255) CONSTRAINT sends_boards_key REFERENCES boards(board_url)
  ,post_title text
  ,post_content text
  ,is_anouncement boolean
  ,FOREIGN KEY(sid)
  REFERENCES submissions
);


CREATE TABLE comments(
	sid integer PRIMARY KEY
  ,pid integer 
  ,comment_content text
  ,FOREIGN KEY(sid)
  REFERENCES submissions(sid)
  ,FOREIGN KEY(pid)
  REFERENCES posts(sid)
);

CREATE TABLE comment_chain(
	sid_parent INTEGER 
  ,sid_child INTEGER PRIMARY KEY
  ,FOREIGN KEY (sid_parent)
  REFERENCES comments(sid)
  ,FOREIGN KEY (sid_child)
  REFERENCES comments(sid)
);

CREATE TABLE user_posts(
  sid integer PRIMARY KEY
  ,FOREIGN KEY(sid)
  REFERENCES posts
);


CREATE TABLE companies(
   cid integer CONSTRAINT comp_key PRIMARY KEY
  ,name varchar(20)
  ,username varchar(50) CONSTRAINT company_user_key references users(username)
 );
 
 CREATE TABLE ads(
   sid integer
  ,cid integer
  ,PRIMARY KEY(sid, cid)
  ,price FLOAT
  ,FOREIGN KEY(sid)
  REFERENCES posts
  ,FOREIGN KEY(cid)
  REFERENCES companies
);
 
CREATE TABLE messages
(
   mid INTEGER NOT NULL CONSTRAINT midkey PRIMARY KEY
  ,mcontent text NOT NULL
  ,u_sends VARCHAR(50) CONSTRAINT messages_user_key references users(username)
  ,u_receives VARCHAR(50) CONSTRAINT messages_user_key2 references users(username)
);

CREATE TABLE links(
  sid integer
	,link_url VARCHAR(50)
	,PRIMARY KEY(sid, link_url)
  ,FOREIGN KEY (sid)
  REFERENCES posts
);

CREATE TABLE subscribes_to(
	username VARCHAR(50)
  ,board_url VARCHAR(255)
  ,PRIMARY KEY(username, board_url)
  ,FOREIGN KEY (username)
  REFERENCES users
  ,FOREIGN KEY (board_url)
  REFERENCES boards
);

CREATE TABLE moderates(
	username VARCHAR(50)
  ,board_url VARCHAR(255)
  ,PRIMARY KEY(username, board_url)
  ,FOREIGN KEY (username)
  REFERENCES users
  ,FOREIGN KEY (board_url)
  REFERENCES boards
);

CREATE TABLE banned(
	 username VARCHAR(50)
  ,board_url VARCHAR(255)
  ,PRIMARY KEY (username, board_url)
  ,FOREIGN KEY (username)
  REFERENCES users
  ,FOREIGN KEY (board_url)
  REFERENCES boards
);

CREATE TABLE rates(
	username VARCHAR(50)
  ,sid INTEGER 
  ,updown VARCHAR(4)
  ,PRIMARY KEY (username, sid)
  ,FOREIGN KEY (username)
  REFERENCES users
  ,FOREIGN KEY (sid)
  REFERENCES submissions
);

CREATE TABLE works_for(
  username VARCHAR(50) 
  ,cid integer
  ,PRIMARY KEY (username,cid)
  ,FOREIGN KEY (username) REFERENCES users
  ,FOREIGN KEY (cid) REFERENCES companies
);
INSERT INTO users VALUES('grab_wasteful246', 'grabwasteful246@earthlink.net', 493, '12-2-2014', 'Grenada', 'true', 'false');
INSERT INTO users VALUES('pianist_honest738', 'pianisthonest738@inbox.com', 8, '3-20-2009', 'Egypt', 'true', 'false');
INSERT INTO users VALUES('honeybee_technological451', 'honeybeetechnological451@yahoo.com', 786, '12-14-2015', 'Nauru', 'true', 'false');
INSERT INTO users VALUES('circle_appropriate809', 'circleappropriate809@earthlink.net', 545, '9-17-2011', 'British Virgin Islands', 'true', 'false');
INSERT INTO users VALUES('dollar_gigantic425', 'dollargigantic425@mail.mcgill.ca', -31, '7-15-2014', 'Australia', 'true', 'false');
INSERT INTO users VALUES('locust_safe103', 'locustsafe103@yahoo.com', 552, '11-22-2002', 'Albania', 'true', 'false');
INSERT INTO users VALUES('director_rotten648', 'directorrotten648@mail.mcgill.ca', 814, '12-3-2016', 'China', 'true', 'false');
INSERT INTO users VALUES('candidate_nervous622', 'candidatenervous622@inbox.com', -498, '7-14-2016', 'Indonesia', 'true', 'false');
INSERT INTO users VALUES('weekend_immense2', 'weekendimmense2@gmail.com', 816, '4-16-2009', 'Côte d’Ivoire', 'true', 'false');
INSERT INTO users VALUES('craft_tired168', 'crafttired168@inbox.com', 183, '3-10-2007', 'Pakistan', 'true', 'false');
INSERT INTO users VALUES('equipment_fine98', 'equipmentfine98@yahoo.com', -872, '11-27-2011', 'Marshall Islands', 'false', 'false');
INSERT INTO users VALUES('attorney_ratty698', 'attorneyratty698@yahoo.com', -972, '8-4-2013', 'New Caledonia', 'false', 'false');
INSERT INTO users VALUES('chip_perfect938', 'chipperfect938@yahoo.com', -245, '10-25-2015', 'Mozambique', 'true', 'false');
INSERT INTO users VALUES('great-grandmother_inland136', 'great-grandmotherinland136@mail.mcgill.ca', -553, '7-20-2009', 'Moldova', 'false', 'false');
INSERT INTO users VALUES('platinum_strange641', 'platinumstrange641@yahoo.com', 388, '12-21-2009', 'Indonesia', 'true', 'false');
INSERT INTO users VALUES('croup_thundering965', 'croupthundering965@mail.mcgill.ca', -829, '9-1-2009', 'Saint Lucia', 'true', 'false');
INSERT INTO users VALUES('cricket_disappointed739', 'cricketdisappointed739@gmail.com', 589, '11-18-2001', 'Austria', 'true', 'false');
INSERT INTO users VALUES('adjustment_dear502', 'adjustmentdear502@outlook.com', 742, '6-6-2007', 'Fiji', 'true', 'false');
INSERT INTO users VALUES('lipstick_dry146', 'lipstickdry146@inbox.com', -132, '1-6-2014', 'Bouvet Island', 'true', 'false');
INSERT INTO users VALUES('curio_quiet944', 'curioquiet944@yahoo.com', 266, '8-7-2013', 'Botswana', 'true', 'false');
INSERT INTO users VALUES('Etienne', 'egmarquet@gmail.com', 9001, '12-2-2002', 'United States', 'true', 'true');
INSERT INTO users VALUES('Ryan', 'ryan@gmail.com', 8999, '12-2-2002', 'United States', 'true', 'true');
INSERT INTO users VALUES('Huey', 'huey@gmail.com', 0, '12-2-2002', 'United States', 'true', 'true');
INSERT INTO users VALUES('Joseph', 'joeseph@gmail.com', -10000, '12-2-2002', 'Canada', 'true', 'true');
INSERT INTO users VALUES('Dog', 'dog@gmail.com', -100, '12-5-2002', 'Canada', 'true', 'true');

-- BOARDS:
INSERT INTO boards VALUES('www.feddit.com/boards/cooking','cooking',434,'A lovely place for cookers to unite to share their spices of life', 'locust_safe103');
INSERT INTO boards VALUES('www.feddit.com/boards/mathematics','mathematics',344,'Eureka, welcome to all SINful mathematicians where we formulate our futures day by day', 'curio_quiet944');
INSERT INTO boards VALUES('www.feddit.com/boards/seduction', 'seduction', 500, 'Come learn all the secrets behind conquering the hearts of the opposite sex', 'Huey');
INSERT INTO boards VALUES('www.feddit.com/boards/fishing', 'fishing', 504, 'Trying to catch the big cod in that nearby like? We bite!', 'lipstick_dry146');
INSERT INTO boards VALUES('www.feddit.com/boards/america', 'america', 911, 'Heehaw! The GREATEST location in the interwebs', 'adjustment_dear502');
INSERT INTO boards VALUES('www.feddit.com/boards/canada', 'canada', 950, 'I like polar bears and beavers', 'Dog');


-- BOARD MODERATORS
INSERT INTO moderates VALUES('locust_safe103', 'www.feddit.com/boards/america'); 
INSERT INTO moderates VALUES('honeybee_technological451', 'www.feddit.com/boards/fishing'); 
INSERT INTO moderates VALUES('Huey', 'www.feddit.com/boards/seduction'); 
INSERT INTO moderates VALUES('cricket_disappointed739', 'www.feddit.com/boards/mathematics'); 
INSERT INTO moderates VALUES('cricket_disappointed739', 'www.feddit.com/boards/cooking');
INSERT INTO moderates VALUES('Dog', 'www.feddit.com/boards/canada');


-- MESSAGES:
INSERT INTO messages VALUES(1 , 'Hey, I saw your post the other day, and it was very cute! Thank you', 'weekend_immense2', 'director_rotten648' );
INSERT INTO messages VALUES(2 , 'Could you send me a link to your github?', 'curio_quiet944', 'Joseph');
INSERT INTO messages VALUES(3 ,'Wow, you actually offended me yesterday, could you apologize via this messaging system', 'platinum_strange641', 'adjustment_dear502');
INSERT INTO messages VALUES(4 , 'Ok I would like to apologize then', 'adjustment_dear502', 'platinum_strange641');
INSERT INTO messages VALUES(5 , 'THIS IS A SPAM MESSAGE , BECAUSE I FELT LIKE SPAMMING YOU', 'cricket_disappointed739', 'equipment_fine98' );
INSERT INTO messages VALUES(6 , 'Be my friend please', 'Ryan', 'Dog' );


INSERT INTO subscribes_to VALUES('locust_safe103', 'www.feddit.com/boards/fishing');  
INSERT INTO subscribes_to VALUES('Joseph', 'www.feddit.com/boards/fishing');  
INSERT INTO subscribes_to VALUES('Huey', 'www.feddit.com/boards/fishing');  
INSERT INTO subscribes_to VALUES('croup_thundering965', 'www.feddit.com/boards/seduction');  
INSERT INTO subscribes_to VALUES('curio_quiet944', 'www.feddit.com/boards/seduction');  
INSERT INTO subscribes_to VALUES('great-grandmother_inland136', 'www.feddit.com/boards/america');  
INSERT INTO subscribes_to VALUES('equipment_fine98', 'www.feddit.com/boards/america');  
INSERT INTO subscribes_to VALUES('Ryan', 'www.feddit.com/boards/mathematics');  
INSERT INTO subscribes_to VALUES('attorney_ratty698', 'www.feddit.com/boards/cooking');  
INSERT INTO subscribes_to VALUES('candidate_nervous622', 'www.feddit.com/boards/america'); 
INSERT INTO subscribes_to VALUES('Ryan', 'www.feddit.com/boards/canada'); 

-- POSTS, COMMENTS, USERPOSTS
-- new board: www.feddit.com/boards/cooking
INSERT INTO submissions VALUES('45382', 'true', '2014-12-18', 'candidate_nervous622');
INSERT INTO posts VALUES('45382', 'www.feddit.com/boards/cooking', 'What is a clam?', 'Sorry if this is the most retarded question ever posted. 

Im in the UK and want to use the superbowl as an excuse to make clam chowder. Problem is i have no fucking clue what a clam is and where to find them in the UK. 

Also its a Sunday, and if there are places near me that sell clams they probably wont be open.
Are there any supermarket substitutes? Muscles or scallops maybe?', 'false');
INSERT INTO user_posts VALUES('45382');
INSERT INTO submissions VALUES('87445', 'true', '2002-03-01', 'Ryan');
INSERT INTO posts VALUES('87445', 'www.feddit.com/boards/cooking', 'Do most online recipes understate the amount of spices used?', 'Im not sure if my taste buds are desensitized or most recipes just understate the amount of spices used. Teaspoon this, teaspoon that, tastes like nothing to me.', 'false');
INSERT INTO user_posts VALUES('87445');
-- new board: www.feddit.com/boards/seduction
INSERT INTO submissions VALUES('88083', 'true', '2017-11-07', 'lipstick_dry146');
INSERT INTO posts VALUES('88083', 'www.feddit.com/boards/seduction', 'Pro tip for finding out if she gave the Right/Wrong number.', '', 'false');
INSERT INTO user_posts VALUES('88083');
INSERT INTO submissions VALUES('87446', 'true', '2006-05-11', 'director_rotten648');
INSERT INTO comments VALUES('87446', '88083', 'This shit happened to me. A guy kept texting me claiming I was a girl named Cynthia. I kept telling him he was given a fake number. 

He called and texted me NONSTOP. He was convinced I was faking. He said he called his cousins and his friend and they all said I had Cynthias number. He called me even when I kept texting him to stop because I was literally at a funeral; guy apologies....And then calls me again like five times during the funeral. 

Brother was thirsty AF. ');
INSERT INTO submissions VALUES('79927', 'true', '2016-12-22', 'locust_safe103');
INSERT INTO comments VALUES('79927', '88083', '[removed]');
INSERT INTO submissions VALUES('39890', 'true', '2013-11-25', 'cricket_disappointed739');
INSERT INTO comments VALUES('39890', '88083', 'Really? No one does the whole "put your number in my phone and Ill call yours back" any more?');
INSERT INTO submissions VALUES('39291', 'true', '2008-08-07', 'Etienne');
INSERT INTO comments VALUES('39291', '88083', 'When I was still looking, I decided to give the girl my number. Id wrap up the conversation, I gotta get back to my friends, let me give you my number and you can text me later. 

Then if she offered me her phone, just type it in, if not just scrawl it on a napkin. Girl doesnt feel on the spot to make a decision of do I like this guy enough to go ahead and give him my number. Then its in her court, she can text or not, but Im not thinking about it anymore, Im doing something else.');
INSERT INTO submissions VALUES('35472', 'true', '2015-11-10', 'cricket_disappointed739');
INSERT INTO comments VALUES('35472', '88083', 'Damn this guy is a player');
INSERT INTO submissions VALUES('67112', 'true', '2006-01-16', 'locust_safe103');
INSERT INTO posts VALUES('67112', 'www.feddit.com/boards/seduction', '"If you are depressed you are living in the past. If you are anxious you are living in the future. If you are at peace you are living in the present. " - Lao Tzu', '', 'false');
INSERT INTO user_posts VALUES('67112');
-- new board: www.feddit.com/boards/fishing
INSERT INTO submissions VALUES('38965', 'true', '2012-11-27', 'circle_appropriate809');
INSERT INTO posts VALUES('38965', 'www.feddit.com/boards/fishing', 'How does my found lure collection like thing look? (Not all of my found lures)', '', 'false');
INSERT INTO user_posts VALUES('38965');
-- new board: www.feddit.com/boards/america
INSERT INTO submissions VALUES('10304', 'true', '2012-09-10', 'craft_tired168');
INSERT INTO posts VALUES('10304', 'www.feddit.com/boards/america', 'Plexiglas or Perspex?', 'Between these, whats the most common term you use/hear? Im writing a book and dont want my American characters sounding like Goddamn commies. :)', 'false');
INSERT INTO user_posts VALUES('10304');
INSERT INTO submissions VALUES('13662', 'true', '2011-01-04', 'locust_safe103');
INSERT INTO comments VALUES('13662', '10304', 'Plexiglass. Never heard of the other term');
INSERT INTO submissions VALUES('13506', 'true', '2002-03-20', 'Huey');
INSERT INTO posts VALUES('13506', 'www.feddit.com/boards/america', 'What are youre steoroypes?', 'Wich people do you consider stupid? Iam Dutch and we make jokes about Belgians being stupid, about who make Americans those jokes? ', 'false');
INSERT INTO user_posts VALUES('13506');
INSERT INTO submissions VALUES('22913', 'true', '2012-03-13', 'director_rotten648');
INSERT INTO comments VALUES('22913', '13506', 'Southerners (US southeast), and people from rural country areas like West Virginia.');
INSERT INTO submissions VALUES('89952', 'true', '2006-08-14', 'cricket_disappointed739');
INSERT INTO comments VALUES('89952', '13506', 'Besides the big one of all dutch being debaucherous heathens...

Id say its fairly well believed that west coast is sort of the laid back, air headed hippie liberal type, the Midwest sort of the wholesome simpleton, and the east coast being rude and rushed.

But then, America being so big, different states will have different stereotypes of adjacent states, and then even in their own state as some are so large.

Being from Massachusetts Ill say that new Yorkers are trash, conneticunts are high class trash, Rhode island is like a shit county of mass and hardly even a state, Maine and new hampshire are alright(although new hampshire looks down at "massholes") and people from Vermont are out of touch granola eating hippies.

I spent some time in Oklahoma so cam attest to that. While a Texan would think an "okie" to be a hayseed Inbred dummy, and Oklahoman thinks Texans are arrogant, full of themself for no reason, and then think neighboring Missouri to be the small time Podunk inbreds.

Could be interesting to hear more stereotypes I never heard of, maybe try putting this in askreddit for more traction.');
-- new board: www.feddit.com/boards/mathematics
INSERT INTO submissions VALUES('96719', 'true', '2015-11-27', 'attorney_ratty698');
INSERT INTO posts VALUES('96719', 'www.feddit.com/boards/mathematics', 'Does x + y + z = xyz?', 'The textbook doesnt say anything about this so Im a little confused. My mum says they arent the same, because if theyre next to each other that means its multiplied. I thought it only gets multiplied when theres a coefficient, and since x + y + z is just pronumerals, theres nothing to multiply it. Sorry if this makes no sense. I know Im probably wrong but if someone can explain this to me that would be great! :)', 'false');
INSERT INTO user_posts VALUES('96719');
INSERT INTO submissions VALUES('52448', 'true', '2017-06-26', 'Joseph');
INSERT INTO posts VALUES('52448', 'www.feddit.com/boards/mathematics', 'Discord for those needing math help.', 'Hi guys hope you all doing well. I made a discord specifically so you guys can ask questions and wont have to wait for a response. Here we try and keep active as possible. If you have a discord and needing help or just chat. Check it out.

https://discord.gg/uqMtEp', 'false');
INSERT INTO user_posts VALUES('52448');
INSERT INTO submissions VALUES('80291', 'true', '2004-10-14', 'chip_perfect938');
INSERT INTO posts VALUES('80291', 'www.feddit.com/boards/mathematics', '-2 - 3 Why did i get this wrong? I got -7', 'Am I wrong here, -2 = -(2x2) = -4', 'false');
INSERT INTO user_posts VALUES('80291');
INSERT INTO submissions VALUES('33282', 'true', '2017-02-16', 'dollar_gigantic425');
INSERT INTO comments VALUES('33282', '80291', 'You are correct:
 -2^2 = -4 
It is (-2)^2 that = 4 

Im assuming its either a mistake in the textbook, or perhaps youve misinterpreted the question.');
INSERT INTO submissions VALUES('46285', 'true', '2011-01-24', 'weekend_immense2');
INSERT INTO comments VALUES('46285', '80291', 'If you look at the picture. If x=2 I guess when you replace x with -2 then you would get (-2) - 3 =1.  Not -2 - 3.  Correct?');
INSERT INTO submissions VALUES('41115', 'true', '2013-08-12', 'dollar_gigantic425');
INSERT INTO comments VALUES('41115', '80291', '-2^2=4');
INSERT INTO submissions VALUES('5992', 'true', '2014-08-08', 'locust_safe103');
INSERT INTO posts VALUES('5992', 'www.feddit.com/boards/mathematics', '4th Grade math left me stumped. Anyone have an answer for this?', 'So Im the resident math homework helper for my granddaughter.  9 times out of 10, the biggest problem we come across is trying to teach it the way I know how instead of the way her teacher told her.  Not arguing for one way or the other, I just end up having to relearn how its being taught today in order to help.  But that isnt what this is about.

Last night, we were going over simple patterns of a series.  1,2,3,4 = Add 1.  10,15,12,17,14 = Add 5, subtract 3.  2,8,4,16,8 = Multiply by 4, divide by 2.  None of it was too terribly difficult until the last one.  I cant for the life of me figure it out with the information provided.  Anyone care to take a stab at it?

1,600,800, ____ , ____ ,100,50, ____

Im willing to give away some reddit silver for the right answer.  ', 'false');
INSERT INTO user_posts VALUES('5992');
INSERT INTO submissions VALUES('23912', 'true', '2013-02-10', 'circle_appropriate809');
INSERT INTO comments VALUES('23912', '5992', 'I think 1,600 represents 1600, not 1 and then 600 in a sequence. 
                            
Given that, the answer is pretty simple: whats the most natural way to go from 1600 to 800? What about from 100 to 50?');
INSERT INTO submissions VALUES('6634', 'true', '2003-01-15', 'Huey');
INSERT INTO posts VALUES('6634', 'www.feddit.com/boards/mathematics', 'When do I use use the U symbol in interval notation?', 'ex.
(#,#)U(#,#)', 'false');
INSERT INTO user_posts VALUES('6634');

-- ADDITIONAL COMMENT CHAINS:
-- parent post id 80291
-- parent comment id: 33282
-- comment chain
INSERT INTO submissions VALUES('2192', 'true', '2014-12-17', 'attorney_ratty698');
INSERT INTO comments VALUES('2192', '80291', 'Yay! Thank you!');
INSERT INTO submissions VALUES('69417', 'true', '2007-06-24', 'great-grandmother_inland136');
INSERT INTO comments VALUES('69417', '80291', 'Is this true??');
INSERT INTO submissions VALUES('80190', 'true', '2008-03-03', 'equipment_fine98');
INSERT INTO comments VALUES('80190', '80291', 'Wow');
INSERT INTO submissions VALUES('90310', 'true', '2009-11-06', 'croup_thundering965');
INSERT INTO comments VALUES('90310', '80291', 'This is really useful!');
INSERT INTO submissions VALUES('96602', 'true', '2006-11-16', 'Etienne');
INSERT INTO comments VALUES('96602', '80291', 'thanks!');
INSERT INTO comment_chain VALUES ('33282','2192');
INSERT INTO comment_chain VALUES ('33282','69417');
INSERT INTO comment_chain VALUES ('33282','80190');
INSERT INTO comment_chain VALUES ('33282','90310');
INSERT INTO comment_chain VALUES ('33282','96602');

-- LINKS
INSERT INTO links VALUES ('88083','www.SUPER_SEDUCTION.com');
INSERT INTO links VALUES ('67112','www.SUPER_SEDUCTION.com');
INSERT INTO links VALUES ('38965','www.SUPER_FISHING.com');
INSERT INTO links VALUES ('13506','www.AMERICAISTHEBEST.com');

--COMPANIES
INSERT INTO companies (cid, name, username) VALUES (5, 'Toyota','pianist_honest738');
INSERT INTO companies (cid, name, username) VALUES (6, 'Volkswagen', 'candidate_nervous622');
INSERT INTO companies (cid, name, username) VALUES (17, 'Daimler','dollar_gigantic425');
INSERT INTO companies (cid, name, username) VALUES (18, 'General Motors','adjustment_dear502');
INSERT INTO companies (cid, name, username) VALUES (21, 'Ford Motor Company','curio_quiet944');

--ads:


-- ad1
INSERT INTO submissions VALUES('77041', 'true', '2015-04-28', 'pianist_honest738');
INSERT INTO posts VALUES('77041', 'www.feddit.com/boards/seduction', 'Ride a Toyota', 'Reliable with a new look.', 'false');
INSERT INTO ads VALUES('77041', 5, 500);
INSERT INTO works_for (username, cid) VALUES ('pianist_honest738', 5);
INSERT INTO rates (username, sid, updown) VALUES ('pianist_honest738', '77041', 'up');                

--ad2
INSERT INTO submissions VALUES('85610', 'true', '2018-03-01', 'candidate_nervous622');
INSERT INTO posts VALUES('85610', 'www.feddit.com/boards/seduction', 'Ride Volkswagen', 'Das Auto.', 'false');
INSERT INTO ads VALUES('85610', 6, 600);
INSERT INTO works_for (username, cid) VALUES ('candidate_nervous622', 6);
INSERT INTO rates (username, sid, updown) VALUES ('candidate_nervous622', '85610', 'up');                  

--ad3
INSERT INTO submissions VALUES('55721', 'true', '2003-06-08', 'dollar_gigantic425');
INSERT INTO posts VALUES('55721', 'www.feddit.com/boards/seduction', 'Ride Daimler', 'Quiet luxury.', 'false');
INSERT INTO ads VALUES('55721', 17, 1700);
INSERT INTO works_for (username, cid) VALUES ('dollar_gigantic425', 17);
INSERT INTO rates (username, sid, updown) VALUES ('dollar_gigantic425', '55721', 'up');                  

--ad4
INSERT INTO submissions VALUES('28492', 'true', '2013-11-11', 'adjustment_dear502');
INSERT INTO posts VALUES('28492', 'www.feddit.com/boards/seduction', 'Drive General Motors', 'Built to last.', 'false');
INSERT INTO ads VALUES('28492', 18, 1800);
INSERT INTO works_for (username, cid) VALUES ('adjustment_dear502', 18);
INSERT INTO rates (username, sid, updown) VALUES ('adjustment_dear502', '28492', 'up');                  

--ad5
INSERT INTO submissions VALUES('4920', 'true', '2015-12-08', 'curio_quiet944');
INSERT INTO posts VALUES('4920', 'www.feddit.com/boards/seduction', 'Drive a Ford.', 'Grab life by the horns.', 'false');
INSERT INTO ads VALUES('4920', 21, 2100);
INSERT INTO works_for (username, cid) VALUES ('curio_quiet944', 21);
INSERT INTO rates (username, sid, updown) VALUES ('curio_quiet944', '4920', 'up');                  

                       
--banned                       
INSERT INTO banned (username, board_url) VALUES ('Etienne', 'www.feddit.com/boards/cooking');                       
INSERT INTO banned (username, board_url) VALUES ('Ryan', 'www.feddit.com/boards/cooking');                       
INSERT INTO banned (username, board_url) VALUES ('Huey', 'www.feddit.com/boards/cooking');                       
INSERT INTO banned (username, board_url) VALUES ('Joseph', 'www.feddit.com/boards/cooking');                       
INSERT INTO banned (username, board_url) VALUES ('weekend_immense2', 'www.feddit.com/boards/cooking');                       

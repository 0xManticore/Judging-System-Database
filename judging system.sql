-- create statements
CREATE TABLE School_Info (
            SchName VARCHAR2(30) NOT NULL,
            SchPostCode NUMBER(5) NOT NULL,
            SchAddr VARCHAR2(30) NOT NULL,
            SchCity VARCHAR2(20) NOT NULL,
            SchState VARCHAR2(20) NOT NULL,
            SchType VARCHAR2(6) NOT NULL,
            CONSTRAINT PK_SchoolInfo PRIMARY KEY (SchName, SchPostCode)
);
 
CREATE TABLE School (
            SchCode NUMBER(10) PRIMARY KEY NOT NULL,
            SchName VARCHAR2(30) NOT NULL,
            SchPostCode NUMBER(5) NOT NULL,
            SchPassword VARCHAR2(12) NOT NULL,
            CONSTRAINT FK_SchName_School FOREIGN KEY (SchName, SchPostCode) REFERENCES School_Info (SchName, SchPostCode)
);
 
CREATE TABLE School_Email (
            SchEmail VARCHAR2(30) PRIMARY KEY NOT NULL,
            SchCode NUMBER(10) NOT NULL,
            CONSTRAINT FK_SchCode_SchoolEmail FOREIGN KEY (SchCode) REFERENCES School (SchCode)
);
 
CREATE TABLE School_Phone (
            SchPhoneNo NUMBER(12) PRIMARY KEY NOT NULL,
            SchCode NUMBER(10) NOT NULL,
            CONSTRAINT FK_SchCode_SchoolPhone FOREIGN KEY (SchCode) REFERENCES School (SchCode)
);
 
CREATE TABLE Organizer_Info  (
            OrgICNo NUMBER(12) PRIMARY KEY NOT NULL,
            OrgName VARCHAR2(30) NOT NULL,
            OrgPosition VARCHAR(20)
);
 
CREATE TABLE Organizer  (
            OrgID NUMBER(10) GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY NOT NULL,
            OrgICNo NUMBER(12) NOT NULL,
            OrgPassword VARCHAR2(12) NOT NULL,
            CONSTRAINT FK_OrgICNo_Organizer FOREIGN KEY (OrgICNo) REFERENCES Organizer_Info (OrgICNo)
);
 
CREATE TABLE Organizer_Email (
            OrgEmail VARCHAR2(30) PRIMARY KEY NOT NULL,
            OrgID NUMBER(10) NOT NULL,
            CONSTRAINT FK_OrgID_OrganizerEmail FOREIGN KEY (OrgID) REFERENCES Organizer (OrgID)
);
 
CREATE TABLE Organizer_Phone (
            OrgPhoneNo NUMBER(12) PRIMARY KEY NOT NULL,
            OrgID NUMBER(10) NOT NULL,
            CONSTRAINT FK_OrgID_OrganizerPhone FOREIGN KEY (OrgID) REFERENCES Organizer (OrgID)
);
 
CREATE TABLE Jury_Team (
            JTeamID NUMBER(10) GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY NOT NULL,
            OrgID NUMBER(10) NOT NULL, 
            CONSTRAINT FK_OrgID_Jury_Team FOREIGN KEY (OrgID) REFERENCES Organizer (OrgID)
);
 
CREATE TABLE Judge_Info (
            JudgeICNo NUMBER(12) PRIMARY KEY NOT NULL,
            JudgeName VARCHAR2(30) NOT NULL
);
 
CREATE TABLE Judge (
            JudgeID NUMBER(10) GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY NOT NULL,
            JudgeICNo NUMBER(12) NOT NULL,
            JudgePassword VARCHAR2(12) NOT NULL,
            JTeamID NUMBER(10),
            CONSTRAINT FK_JTeamID_Judge FOREIGN KEY (JTeamID) REFERENCES Jury_Team (JTeamID),
            CONSTRAINT FK_JudgeICNo_Judge FOREIGN KEY (JudgeICNo) REFERENCES Judge_Info (JudgeICNo)
);
 
CREATE TABLE Judge_Email (
            JudgeEmail VARCHAR2(30) PRIMARY KEY NOT NULL,
            JudgeID NUMBER(10) NOT NULL,
            CONSTRAINT FK_JudgeID_JudgeEmail FOREIGN KEY (JudgeID) REFERENCES Judge (JudgeID)
);
 
CREATE TABLE Judge_Phone (
            JudgePhoneNo NUMBER(12) PRIMARY KEY NOT NULL,
            JudgeID NUMBER(10) NOT NULL,
            CONSTRAINT FK_JudgeID_JudgePhone FOREIGN KEY (JudgeID) REFERENCES Judge (JudgeID)
);
 
CREATE TABLE Supervision (
            JudgeID NUMBER(10) NOT NULL,
            CONSTRAINT FK_JudgeID_Supervision FOREIGN KEY (JudgeID) REFERENCES Judge (JudgeID)
);
 
CREATE TABLE Material_Submission (
            SubmissionTime TIMESTAMP PRIMARY KEY NOT NULL,
            EposterID NUMBER(10) NOT NULL,
            VideoLink VARCHAR2(255) NOT NULL,
            FbLink VARCHAR2(255) NOT NULL
);
 
CREATE TABLE Material (
            MatID NUMBER(10) GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY NOT NULL,
            SubmissionTime TIMESTAMP NOT NULL,
            MaterialComment VARCHAR2(255), 
            SchCode NUMBER(10) NOT NULL,
            JTeamID NUMBER(10),
            CONSTRAINT FK_SchCode_Material FOREIGN KEY (SchCode) REFERENCES School(SchCode),
            CONSTRAINT FK_JTeamID_Material FOREIGN KEY (JTeamID) REFERENCES Jury_Team (JTeamID),
            CONSTRAINT FK_SubmissionTime_Material FOREIGN KEY (SubmissionTime) REFERENCES Material_Submission (SubmissionTime)
);
 
 
CREATE TABLE Judge_Remark (
            JudgingDate DATE NOT NULL,
            JudgeComment VARCHAR2(255),
            FinalMarkVerifyTime TIMESTAMP NOT NULL,
            TotalMark NUMBER(10) NOT NULL,
            MatID NUMBER(10) NOT NULL,
            JudgeID NUMBER(10) NOT NULL,
            CONSTRAINT FK_MatID_JudgeRemark FOREIGN KEY (MatID) REFERENCES Material (MatID),
            CONSTRAINT FK_JudgeID_JudgeRemark FOREIGN KEY (JudgeID) REFERENCES Judge (JudgeID)
);
 
CREATE TABLE Final_Rank (
            Ranking VARCHAR2(15) NOT NULL, 
            MatID NUMBER(10) NOT NULL,
            AnnounceRankDate DATE,
            CONSTRAINT PK_Rank PRIMARY KEY (Ranking, MatID),
            CONSTRAINT FK_MatID_Rank FOREIGN KEY (MatID) REFERENCES Material (MatID)
);
 
CREATE TABLE Amendment (
            AmmID NUMBER(10) GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY NOT NULL,
            AmmReason VARCHAR2(255) NOT NULL,
            AmmEvidence VARCHAR2(255),
            MatID NUMBER(10) NOT NULL,
            OrgID NUMBER(10),
            JudgeID NUMBER(10),
            CONSTRAINT FK_MatID_Amendment FOREIGN KEY (MatID) REFERENCES Material (MatID),
            CONSTRAINT FK_OrgID_Ammendment FOREIGN KEY (OrgID) REFERENCES Organizer (OrgID),
            CONSTRAINT FK_JudgeID_Ammendment FOREIGN KEY (JudgeID) REFERENCES Judge(JudgeID)
);
-- Data insertion into School_Info --
 
INSERT INTO School_Info
VALUES ('SK SERI MAWAR', 23400, 'JALAN MEWAH', 'CHANGLUN', 'KEDAH', 'SK');
 
INSERT INTO School_Info
VALUES ('SK KAMPUNG JASIN', 54700, 'JALAN RAMBUTAN', 'JASIN', 'MELAKA', 'SK');
 
INSERT INTO School_Info
VALUES ('SJK(C) KHOON HOE', 11800, 'JALAN AKAR', 'BAYAN LEPAS', 'PULAU PINANG', 'SJK(C)');
 
INSERT INTO School_Info
VALUES ('SJK(T) RAJAJI', 41800, 'JALAN UBI', 'KERIAN', 'PERAK', 'SJK(T)');
 
INSERT INTO School_Info
VALUES ('SK POKOK SEMPADAN', 35010, 'JALAN IKAN', 'PADANG BESAR', 'PERLIS', 'SK');
 
INSERT INTO School_Info
VALUES ('SJK(C) TEIK HONG', 97700, 'JALAN ITIK', 'KOTA BHARU', 'KELANTAN', 'SJK(C)');
 
INSERT INTO School_Info
VALUES ('SJK(T) SUBRAMANIYA', 33900, 'JALAN CENGGAL', 'NILAI', 'NEGERI SEMBILAN', 'SJK(T)');
 
INSERT INTO School_Info
VALUES ('SJK(C) CHONG WAH', 79310, 'JALAN MERDU', 'RAWANG', 'SELANGOR', 'SJK(C)');
 
INSERT INTO School_Info
VALUES ('SK TASIK MUTIARA', 86400, 'JALAN PANTAI', 'DUNGUN', 'TERENGGANU', 'SK');
 
INSERT INTO School_Info
VALUES ('SK BAGAN RESAK', 45500, 'JALAN KAYU', 'GERIK', 'PERAK', 'SK');
 
 
 
-- Data insertion into School --
 
INSERT INTO School
VALUES (175913, 'SK SERI MAWAR', 23400, 'serimawar123');
 
INSERT INTO School
VALUES (149599, 'SK KAMPUNG JASIN', 54700, 'sk_Jasin5678');
 
INSERT INTO School
VALUES (334456, 'SJK(C) KHOON HOE', 11800, 'khoonhoe819');
 
INSERT INTO School
VALUES (819331, 'SJK(T) RAJAJI', 41800, 'rajajiBest88');
 
INSERT INTO School
VALUES (756834, 'SK POKOK SEMPADAN', 35010, 'skpokok5353');
 
INSERT INTO School
VALUES (227584, 'SJK(C) TEIK HONG', 97700, 'teikHong007');
 
INSERT INTO School
VALUES (280082, 'SJK(T) SUBRAMANIYA', 33900, 'maniya_0189');
 
INSERT INTO School
VALUES (579135, 'SJK(C) CHONG WAH', 79310, 'chongWAH693');
 
INSERT INTO School
VALUES (154000, 'SK TASIK MUTIARA', 86400, 'mutiara08532');
 
INSERT INTO School
VALUES (669131, 'SK BAGAN RESAK', 45500, 'baganResak5');
 
 
 
-- Data insertion into School_Email --
 
INSERT INTO School_Email
VALUES ('skserimawar@edu.my' ,175913);
 
INSERT INTO School_Email
VALUES ('skkampungjasin@edu.my', 149599);
 
INSERT INTO School_Email
VALUES ('sjkckhoonhoe@edu.my', 334456);
 
INSERT INTO School_Email
VALUES ('sjktrajaji@edu.my', 819331);
 
INSERT INTO School_Email
VALUES ('skpokoksempadan@edu.my', 756834);
 
INSERT INTO School_Email
VALUES ('sjkcteikhong@edu.my', 227584);
 
INSERT INTO School_Email
VALUES ('sjktsubramaniya@edu.my', 280082);
 
INSERT INTO School_Email
VALUES ('sjkcchongwah@edu.my', 579135);
 
INSERT INTO School_Email
VALUES ('sktasikmutiara1@edu.my', 154000);
 
INSERT INTO School_Email
VALUES ('sktasikmutiara2@edu.my', 154000);
 
INSERT INTO School_Email
VALUES ('skbaganresak1@edu.my', 669131);
 
INSERT INTO School_Email
VALUES ('skbaganresak2@edu.my', 669131);
 
 
 
-- Data insertion into School_Phone --
 
INSERT INTO School_Phone
VALUES (68401395 ,175913);
 
INSERT INTO School_Phone
VALUES (75912830 ,149599);
 
INSERT INTO School_Phone
VALUES (31923895 ,334456);
 
INSERT INTO School_Phone
VALUES (57381900 ,819331);
 
INSERT INTO School_Phone
VALUES (84839205 ,756834);
 
INSERT INTO School_Phone
VALUES (13728163 ,227584);
 
INSERT INTO School_Phone
VALUES (67583917 ,280082);
 
INSERT INTO School_Phone
VALUES (38373815 ,579135);
 
INSERT INTO School_Phone
VALUES (63964112 ,154000);
 
INSERT INTO School_Phone
VALUES (37198674 ,669131);
 
INSERT INTO School_Phone
VALUES (55732264 ,669131);
 
 
 
-- Data insertion into Organizer_Info --
 
INSERT INTO Organizer_Info
VALUES (741015045910, 'Nurulhuda Binti Mohd Hassan', 'Event Manager');
 
INSERT INTO Organizer_Info
VALUES (710626035672, 'Siti Nur Hanis Binti Rahim', 'Financial Audit');
 
INSERT INTO Organizer_Info (OrgICNo, OrgName)
VALUES (800205015893, 'Alex Teh Chern Wei');
 
INSERT INTO Organizer_Info (OrgICNo, OrgName)
VALUES (821121075137, 'Viknesh Raju A/L Siva');
 
INSERT INTO Organizer_Info (OrgICNo, OrgName)
VALUES (690306025172, 'Lee Pei Yen');
 
INSERT INTO Organizer_Info
VALUES (910429045660, 'Wan Aishah Binti Wan Haziq', 'Assistant Secretary');
 
INSERT INTO Organizer_Info
VALUES (850709065344, 'Vinithaa A/P Chakraborty', 'Event Coordinator');
 
INSERT INTO Organizer_Info (OrgICNo, OrgName)
VALUES (750506035517, 'Neoh Soon Kean');
 
INSERT INTO Organizer_Info (OrgICNo, OrgName)
VALUES (651231055149, 'Mohd Luqman Bin Nazir');
 
INSERT INTO Organizer_Info (OrgICNo, OrgName)
VALUES (620808065275, 'Douglas K. Edward');
 
 
 
-- Data insertion into Organizer --
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (741015045910, 'nurulhuda123');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (710626035672, 'sitinurhanis');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (800205015893, 'chernwei0205');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (821121075137, 'viknesh1121');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (690306025172, 'peiyen0306');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (910429045660, 'wanaishah04');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (850709065344, 'vinithaa0709');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (750506035517, 'nsk750506');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (651231055149, 'luqman123165');
 
INSERT INTO Organizer(OrgICNo, OrgPassword) 
VALUES (620808065275, 'douglas0808');
 
 
 
-- Data insertion into Organizer_Email --
 
INSERT INTO Organizer_Email
VALUES ('nurulhuda@gmail.com', 1);
 
INSERT INTO Organizer_Email
VALUES ('sitinurhanis@gmail.com', 2);
 
INSERT INTO Organizer_Email
VALUES ('alextanchernwei@gmail.com', 3);
 
INSERT INTO Organizer_Email
VALUES ('viknesh1121@gmail.com', 4);
 
INSERT INTO Organizer_Email
VALUES ('leepeiyen@gmail.com', 5);
 
INSERT INTO Organizer_Email
VALUES ('wanaishah04@gmail.com', 6);
 
INSERT INTO Organizer_Email
VALUES ('vinithaa@gmail.com', 7);
 
INSERT INTO Organizer_Email
VALUES ('neohsoonkean@gmail.com', 8);
 
INSERT INTO Organizer_Email
VALUES ('luqmanmohd@gmail.com', 9);
 
INSERT INTO Organizer_Email
VALUES ('douglaserward@gmail.com', 10);
 
 
 
-- Data insertion into Organizer_Phone --
 
INSERT INTO Organizer_Phone
VALUES (12359193, 1);
 
INSERT INTO Organizer_Phone
VALUES (23177859, 2);
 
INSERT INTO Organizer_Phone
VALUES (76949105, 3);
 
INSERT INTO Organizer_Phone
VALUES (35278515, 4);
 
INSERT INTO Organizer_Phone
VALUES (21223311, 5);
 
INSERT INTO Organizer_Phone
VALUES (98675423, 6);
 
INSERT INTO Organizer_Phone
VALUES (65819236, 7);
 
INSERT INTO Organizer_Phone
VALUES (17562564, 8);
 
INSERT INTO Organizer_Phone
VALUES (75816385, 9);
 
INSERT INTO Organizer_Phone
VALUES (88661822, 10);
 
 
 
-- Data insertion into Jury_Team --
 
INSERT INTO Jury_Team(OrgID) 
VALUES (3);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (4);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (5);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (8);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (9);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (10);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (8);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (3);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (5);
 
INSERT INTO Jury_Team(OrgID) 
VALUES (9);
 
 
 
-- Data insertion into Judge_Info --
 
INSERT INTO Judge_Info
VALUES (770529045601, 'Mohd Faizul Bin Bakar');
 
INSERT INTO Judge_Info
VALUES (840930075053, 'Chan Soo Beng');
 
INSERT INTO Judge_Info
VALUES (660123045678, 'Rosnah Binti Jaafar');
 
INSERT INTO Judge_Info
VALUES (710331085521, 'Jeganathan A/L Maniam');
 
INSERT INTO Judge_Info
VALUES (880405015745, 'Mustafa Yusof Bin Ishak');
 
INSERT INTO Judge_Info
VALUES (750721095432, 'Sandra Mok Hooi Chin');
 
INSERT INTO Judge_Info
VALUES (941111015117, 'Aloysius Frederick');
 
INSERT INTO Judge_Info
VALUES (820206165226, 'Ashvin A/P Ramasamy');
 
INSERT INTO Judge_Info
VALUES (730831045229, 'Jamaluddin Hussein Bin Abu');
 
INSERT INTO Judge_Info
VALUES (680619055436, 'Rahimah Aishah Binti Samsudin');
 
 
 
-- Data insertion into Judge --
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (770529045601, 'mohdfaizul1', 1);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (840930075053, 'soobeng1450', 2);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (660123045678, 'rosnah7890', 3);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (710331085521, 'jeganathan7', 4);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (880405015745, 'yusof880405', 5);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (750721095432, 'sandramok75', 5);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (941111015117, 'aloysius94', 4);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (820206165226, 'ashvin5226', 3);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (730831045229, 'jamal730831', 2);
 
INSERT INTO Judge(JudgeICNo, JudgePassword, JTeamID) 
VALUES (680619055436, 'aishah68', 1);
 
 
 
-- Data insertion into Judge_Email --
 
INSERT INTO Judge_Email
VALUES ('mohdfaizul@gmail.com', 1);
 
INSERT INTO Judge_Email
VALUES ('soobengchan@gmail.com', 2);
 
INSERT INTO Judge_Email
VALUES ('rosnah@gmail.com', 3);
 
INSERT INTO Judge_Email
VALUES ('jega5521@gmail.com', 4);
 
INSERT INTO Judge_Email
VALUES ('yusof88@gmail.com', 5);
 
INSERT INTO Judge_Email
VALUES ('sandramok75@gmail.com', 6);
 
INSERT INTO Judge_Email
VALUES ('aloysius@gmail.com', 7);
 
INSERT INTO Judge_Email
VALUES ('ashvin82@gmail.com', 8);
 
INSERT INTO Judge_Email
VALUES ('jamal7308@gmail.com', 9);
 
INSERT INTO Judge_Email
VALUES ('rahimah68@gmail.com', 10);
 
 
 
-- Data insertion into Judge_Phone --
 
INSERT INTO Judge_Phone
VALUES (75918232, 1);
 
INSERT INTO Judge_Phone
VALUES (37615801, 2);
 
INSERT INTO Judge_Phone
VALUES (28636729 , 3);
 
INSERT INTO Judge_Phone
VALUES (15196965, 4);
 
INSERT INTO Judge_Phone
VALUES (31466856, 5);
 
INSERT INTO Judge_Phone
VALUES (23580453 , 6);
 
INSERT INTO Judge_Phone
VALUES (44676549, 7);
 
INSERT INTO Judge_Phone
VALUES (68431167, 8);
 
INSERT INTO Judge_Phone
VALUES (92156155, 9);
 
INSERT INTO Judge_Phone
VALUES (84754426, 10);
 
 
 
-- Data insertion into Supervision --
 
INSERT INTO Supervision
VALUES (1);
 
INSERT INTO Supervision
VALUES (2);
 
INSERT INTO Supervision
VALUES (3);
 
INSERT INTO Supervision
VALUES (4);
 
INSERT INTO Supervision
VALUES (5);
 
INSERT INTO Supervision
VALUES (6);
 
INSERT INTO Supervision
VALUES (7);
 
INSERT INTO Supervision
VALUES (8);
 
INSERT INTO Supervision
VALUES (9);
 
INSERT INTO Supervision
VALUES (10);
 
 
 
-- Data insertion into Material_Submission --
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-11-28 11:10:03','yyyy/mm/dd hh24:mi:ss'), 1, 'https://youtu.be/yhKUCZI4s1c', 'www.facebook/submission1');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-11-28 14:52:22','yyyy/mm/dd hh24:mi:ss'), 2, 'https://youtu.be/8FqlTslU22s', 'www.facebook/submission2');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-11-28 19:45:13','yyyy/mm/dd hh24:mi:ss'), 3, 'https://youtu.be/8cL5rYnW1Bw?list=UUPLAYER_UUpT9kL2Eba91BB9CK6wJ4Pg', 'www.facebook/submission3');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-11-29 00:00:02','yyyy/mm/dd hh24:mi:ss'), 4, 'https://youtu.be/hFZFjoX2cGg', 'www.facebook/submission4');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-11-29 04:32:59','yyyy/mm/dd hh24:mi:ss'), 5, 'https://youtu.be/0MlZdmqJvG0', 'www.facebook/submission5');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-11-26 16:44:04','yyyy/mm/dd hh24:mi:ss'), 6, 'https://youtu.be/KdkOKsrWfL4', 'www.facebook/submission6');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-12-03 13:25:37','yyyy/mm/dd hh24:mi:ss'), 7, 'https://youtu.be/E9YBkC9WwHg?list=UUPLAYER_UUX4auhvsqthZe5Ncdf0xXLA', 'www.facebook/submission7');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-12-02 22:51:09','yyyy/mm/dd hh24:mi:ss'), 8, 'https://youtu.be/EPb9Fr63rBU', 'www.facebook/submission8');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-12-01 15:26:41','yyyy/mm/dd hh24:mi:ss'), 9, 'https://youtu.be/-Qllc4M3pjk?list=UUPLAYER_UUhsteS_YFQWQkDyrEdqIOSA', 'www.facebook/submission9');
 
INSERT INTO Material_Submission
VALUES (TO_TIMESTAMP('2020-12-03 23:59:55','yyyy/mm/dd hh24:mi:ss'), 10, 'https://youtu.be/KX_P9_BqorY?list=UUPLAYER_UU79xQjmNtw9GptENKvfLtjw', 'www.facebook/submission10');
 
 
 
-- Data insertion into Material --
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-11-28 11:10:03','yyyy/mm/dd hh24:mi:ss'), 175913);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-11-28 14:52:22','yyyy/mm/dd hh24:mi:ss'), 149599);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-11-28 19:45:13','yyyy/mm/dd hh24:mi:ss'), 334456);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-11-29 00:00:02','yyyy/mm/dd hh24:mi:ss'), 819331);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-11-29 04:32:59','yyyy/mm/dd hh24:mi:ss'), 756834);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-11-26 16:44:04','yyyy/mm/dd hh24:mi:ss'), 227584);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-12-03 13:25:37','yyyy/mm/dd hh24:mi:ss'), 280082);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-12-02 22:51:09','yyyy/mm/dd hh24:mi:ss'), 579135);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-12-01 15:26:41','yyyy/mm/dd hh24:mi:ss'), 154000);
 
INSERT INTO Material(SubmissionTime, SchCode) 
VALUES (TO_TIMESTAMP('2020-12-03 23:59:55','yyyy/mm/dd hh24:mi:ss'), 669131);
 
 
 
-- Data insertion into Judge_Remark--
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Good job', SYSTIMESTAMP, 104, 1, 1);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Nice work', SYSTIMESTAMP, 89, 2, 2);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Keep it up', SYSTIMESTAMP, 76, 3, 3);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Bravo', SYSTIMESTAMP, 118, 4, 4);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Need improvement', SYSTIMESTAMP, 72, 5, 5);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Great effort', SYSTIMESTAMP, 108, 6, 6);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Poster quality is low, Video is at average standard', SYSTIMESTAMP, 52, 7, 7);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'So far the best exhibitor', SYSTIMESTAMP, 131, 8, 8);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Facebook link given is broken', SYSTIMESTAMP, 73, 9, 9);
 
INSERT INTO Judge_Remark
VALUES (SYSDATE, 'Great job', SYSTIMESTAMP, 96, 10, 10);
 
 
 
-- Data insertion into Final_Rank--
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Gold' , 1);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Silver' , 2);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Silver' , 3);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Gold' , 4);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Silver' , 5);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Gold' , 6);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Bronze' , 7);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Gold' , 8);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Silver' , 9);
 
INSERT INTO Final_Rank(Ranking, MatID)
VALUES ('Silver' , 10);
 
 
 
-- Data insertion into Amendment--
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Mistakenly give the wrong marks in criteria 4', 'Please refer to picture attached', 1, 1);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Accidentally skipped criteria 6', 'As shown in this picture', 2, 2);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Wrong marks are given at criteria 1 and 2', 'The marks should be less than the initial marks', 3, 3);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Wrong marks are given at criteria 5', 'The material deserves more marks', 4, 4);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Wrong marks are given at criteria 7', 'Accidentally assigned 10 marks instead of 7', 5, 5);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('I skipped marking criteria 2', 'Marks for criteria 2 was 0 and it should be 8', 6, 6);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('I should revise all the marks given', 'Has intention of faking submission material', 7, 7);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Mistakenly finalised the mark without proper checking', 'Total marks should be less than initial one', 8, 8);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('Less mark should be given', 'As Facebook link provided is malfunctioned', 9, 9);
 
INSERT INTO Amendment(AmmReason, AmmEvidence, MatID, JudgeID)
VALUES ('More mark should be given', 'The material deserves a GOLD medal', 10, 10);

-- DROP statements

DROP TABLE School_Info cascade constraints;
DROP TABLE School cascade constraints;
DROP TABLE School_Email cascade constraints;
DROP TABLE School_Phone cascade constraints;
DROP TABLE Organizer_Info cascade constraints;
DROP TABLE Organizer cascade constraints;
DROP TABLE Organizer_Email cascade constraints;
DROP TABLE Organizer_Phone cascade constraints;
DROP TABLE Jury_Team cascade constraints;
DROP TABLE Judge_Info cascade constraints;
DROP TABLE Judge cascade constraints;
DROP TABLE Judge_Email cascade constraints;
DROP TABLE Judge_Phone cascade constraints;
DROP TABLE Supervision cascade constraints;
DROP TABLE Material_Submission cascade constraints;
DROP TABLE Material cascade constraints;
DROP TABLE Judge_Remark cascade constraints;
DROP TABLE Final_Rank cascade constraints;
DROP TABLE Amendment cascade constraints;
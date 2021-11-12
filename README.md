# Judging-System-Database
OracleSQL statements used to create Judging System Database, insert sample data, and drop the tables in the end.

## Logical ERD
![LogicalERD](https://github.com/0xManticore/Judging-System-Database/blob/main/erd.jpeg)

## 3rd Normal Form
```
School (SchCode, SchName, SchPostCode, SchPassword)
PK: SchCode

School_Info (SchName, SchPostCode, SchAddr, SchCity, SchState)
PK: SchName, SchPostCode
FK1: SchName references School (SchName)
FK2: SchName references School (SchPostCode) 

School_Email (SchEmail, SchCode)
PK: SchEmail
FK: SchCode references School (SchCode)

School_Phone (SchPhoneNo, SchCode) 
PK: SchPhoneNo
FK: SchCode references School (SchCode)

Organizer (OrgID, OrgICNo, OrgPassword)
PK: OrgID

Organizer_Info (OrgICNo, OrgName, OrgPosition)
PK: OrgICNo
FK: OrgICNo references Organizer (OrgICNo)

Organizer_Email (OrgEmail, OrgID)
PK: OrgEmail
FK: OrgID references Organizer (OrgID)
 

Organizer_Phone (OrgPhoneNo, OrgID)
PK: OrgPhoneNo
FK1: OrgID references Organizer (OrgID)

JuryTeam (JTeamID, OrgID)
PK: JTeamID
FK1: OrgID references Organizer (OrgID)
 
Judge (JudgeID, JudgeICNo, JudgePassword, JTeamID)
PK: JudgeID
FK1: JTeamID references JuryTeam (JTeamID)

Judge_Info (JudgeICNo, JudgeName)
PK: JudgeICNo
FK1: JudgeICNo reference Judge (JudgeICNo)

Judge_Email (JudgeEmail, JudgeID)
PK: JudgeEmail
FK1: JudgeID references Judge (JudgeID)

Judge_Phone (JudgePhoneNo, JudgeID)
PK: JudgePhoneNo
FK1: JudgeID references Judge (JudgeID)
 
Supervision (JudgeID)
PK: None
FK1: JudgeID references Judge (JudgeID)
 

Material (MatID, SubmissionTime, SubmissionDate, MaterialComment, SchCode, JTeamID)
PK: MatID
FK1: SchCode references School (SchCode)
FK2: JTeamID references JuryTeam (JTeamID)

Material_Submission(SubmissionTime, SubmissionDate, EposterID, VideoLink, FbLink)
PK: SubmissionTime, SubmissionDate
FK1: SubmissionTime references Material (SubmissionTime)
FK2: SubmissionDate references Material (SubmissionDate )
 
Judge_Remark (JudgingDate, JudgeComment, FinalMarkVerifyTime, TotalMark, MatID, JudgeID)
PK: None
FK1: MatID references Material (MatID)
FK2: JudgeID references Judge (JudgeID)
 
Final_Rank (Ranking, AnnounceRankDate, MatID)
PK: Ranking, MatID
FK: MatID references Material (MatID)
 
Amendment (AmmID, AmmReason, AmmEvidence, MatID, OrgID)
PK: AmmID
FK1: MatID references Material (MatID)
FK2: OrgID references Organizer (OrgID)
```
## User view
![Userview](https://user-images.githubusercontent.com/61949488/141510669-104f5512-15d8-42a7-89e3-8d72c92d658c.png)

## Author

- [@Saleh_Mohamed](https://github.com/0xManticore)


## 🚀 About Me
I'm Saleh Mohamed, software developer and computer science student with over 3 years of academic and professional experience in front-end development / web penetration testing.

-- Users Table

create table Users (
userId int identity(1,1) primary key,
fullName nvarchar(100) not null,
email nvarchar(256) not null,
userName nvarchar(50) not null,
PinHash nvarchar(500) not null,

[Role] nvarchar(20) not null constraint df_Users_Role DEFAULT('Teacher'),
ApprovalStatus nvarchar(20) not null constraint df_Users_ApprovalStatus DEFAULT('Pending'),

ApprovedByUserId int null,
ApprovedAt DATETIME2 NULL,

CreatedAt DATETIME2 not null constraint DF_Users_CreatedAt DEFAULT (SYSUTCDATETIME()),

Constraint UQ_Users_Email UNIQUE(Email),
Constraint UQ_Users_Username  UNIQUE(Username),

Constraint Ck_Users_Role check (Role in ('Admin','Teacher')),

constraint ck_Users_ApprovalStatus check (ApprovalStatus in ('Pending','Approved','Rejected')),

constraint ck_Users_Admin_Approval check (Role <> 'Admin' or Approvalstatus = 'Approved'),

constraint fk_Users_Approvedby Foreign key(ApprovedByUserId) references Users(UserId)


);


-- Departments Table

create table Departments
(
  DepartmentId int identity(1,1) primary key,
  DepartmentName nvarchar(100) not null,
  IsActive BIT not null constraint DF_Departments_IsActive default(1),

  constraint UQ_Departments_DepartmentName unique(DepartmentName) 
);


--Students table

create table Students
(
  StudentId int identity(1,1) primary key,
  RollNumber nvarchar(30) not null,
  StudentName nvarchar(100) not null,
  DepartmentId int not null,
  YearOfStudy int not null,
  IsActive bit not null constraint DF_Students_IsActive default(1),
  
  constraint UQ_Students_RollNumber  Unique(RollNumber),
  constraint CK_Students_YearOFStudy  check(YearOfStudy between 1 and 4),
  constraint fk_Students_Departments Foreign key(DepartmentId) references Departments(DepartmentId)

);

-- Attendance

create table Attendance 
(
AttendanceId int identity(1,1) primary key,
StudentId int not null ,
AttendanceDate DATE NOT NULL,
AttendanceStatus nvarchar(10) not null,
MarkedByUserId int not null,

CreatedAt DATETIME2 not null constraint DF_Attendance_CreatedAt default(SYSUTCDATETIME()),

constraint ck_Attendance_status check(AttendanceStatus in ('Present' , 'Absent')),
constraint fk_StudentId foreign key(StudentId) references Students(StudentId) , 
constraint fk_Attendence_Users foreign key(MarkedByUserId) references Users(UserId),
constraint UQ_Attendance_Student_Date unique(StudentId , AttendanceDate)
);

-- select table_name from INFORMATION_SCHEMA.tables where table_type = 'base table' order by table_name;

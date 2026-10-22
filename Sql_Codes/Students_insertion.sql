/*
GO

-- Insert departments if missing
IF NOT EXISTS (
    SELECT 1 FROM Departments
    WHERE DepartmentName = 'CSE'
)
    INSERT INTO Departments (DepartmentName)
    VALUES ('CSE');

IF NOT EXISTS (
    SELECT 1 FROM Departments
    WHERE DepartmentName = 'ECE'
)
    INSERT INTO Departments (DepartmentName)
    VALUES ('ECE');

IF NOT EXISTS (
    SELECT 1 FROM Departments
    WHERE DepartmentName = 'IT'
)
    INSERT INTO Departments (DepartmentName)
    VALUES ('IT');

IF NOT EXISTS (
    SELECT 1 FROM Departments
    WHERE DepartmentName = 'MECH'
)
    INSERT INTO Departments (DepartmentName)
    VALUES ('MECH');


GO

-- Insert sample students if missing
IF NOT EXISTS (
    SELECT 1 FROM Students
    WHERE RollNumber = 'CS2026001'
)
    INSERT INTO Students
        (RollNumber, StudentName, DepartmentId, YearOfStudy)
    SELECT 'CS2026001', 'Arjun', DepartmentId, 1
    FROM dbo.Departments
    WHERE DepartmentName = 'CSE';

IF NOT EXISTS (
    SELECT 1 FROM Students
    WHERE RollNumber = 'CS2026002'
)
    INSERT INTO Students
        (RollNumber, StudentName, DepartmentId, YearOfStudy)
    SELECT 'CS2026002', 'Priya', DepartmentId, 1
    FROM dbo.Departments
    WHERE DepartmentName = 'CSE';

IF NOT EXISTS (
    SELECT 1 FROM Students
    WHERE RollNumber = 'EC2026001'
)
    INSERT INTO Students
        (RollNumber, StudentName, DepartmentId, YearOfStudy)
    SELECT 'EC2026001', 'Sneha', DepartmentId, 1
    FROM dbo.Departments
    WHERE DepartmentName = 'ECE';

IF NOT EXISTS (
    SELECT 1 FROM dbo.Students
    WHERE RollNumber = 'CS2025001'
)
    INSERT INTO dbo.Students
        (RollNumber, StudentName, DepartmentId, YearOfStudy)
    SELECT 'CS2025001', 'Ravan', DepartmentId, 2
    FROM dbo.Departments
    WHERE DepartmentName = 'CSE';

*/


IF NOT EXISTS (
    SELECT 1 FROM dbo.Students
    WHERE RollNumber = 'IT2025001'
)
    INSERT INTO dbo.Students
        (RollNumber, StudentName, DepartmentId, YearOfStudy)
    SELECT 'IT2025001', 'Hema', DepartmentId, 2
    FROM dbo.Departments
    WHERE DepartmentName = 'IT';

IF NOT EXISTS (
    SELECT 1 FROM dbo.Students
    WHERE RollNumber = 'MECH2024001'
)
    INSERT INTO dbo.Students
        (RollNumber, StudentName, DepartmentId, YearOfStudy)
    SELECT 'MECH2024001', 'Siri', DepartmentId, 3
    FROM dbo.Departments
    WHERE DepartmentName = 'MECH';
GO

-- Verify the inserted records
SELECT * FROM dbo.Departments;

SELECT
    s.StudentId,
    s.RollNumber,
    s.StudentName,
    d.DepartmentName,
    s.YearOfStudy,
    s.IsActive
FROM dbo.Students AS s
INNER JOIN dbo.Departments AS d
    ON s.DepartmentId = d.DepartmentId
ORDER BY s.RollNumber;
GO

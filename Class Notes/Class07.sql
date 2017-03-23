--- Exercise 7.2 ---

CREATE VIEW CSView AS
SELECT *
FROM COURSE c
WHERE c.dept = 'CS';

CREATE VIEW SectionView AS
SELECT s.id, s.letter, s.semester, s.prof, c.dept, c.code, c.name
FROM Course c, Section s
WHERE c.dept = 'CS'
AND c.id = s.courseId;

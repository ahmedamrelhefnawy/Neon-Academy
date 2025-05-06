INSERT INTO app_user (password, fname, lname, email, dob, gender, picture, phone) VALUES
-- Students (uid 1-10)
('pass1', 'John', 'Doe', 'john@example.com', '2000-01-01', 'male', 'pic1.jpg', '01000000001'),
('pass2', 'Jane', 'Smith', 'jane@example.com', '2000-02-02', 'female', 'pic2.jpg', '01000000002'),
('pass3', 'Mike', 'Brown', 'mike@example.com', '2000-03-03', 'male', 'pic3.jpg', '01000000003'),
('pass4', 'Lucy', 'Davis', 'lucy@example.com', '2000-04-04', 'female', 'pic4.jpg', '01000000004'),
('pass5', 'Tom', 'Wilson', 'tom@example.com', '2000-05-05', 'male', 'pic5.jpg', '01000000005'),
('pass6', 'Anna', 'Taylor', 'anna@example.com', '2000-06-06', 'female', 'pic6.jpg', '01000000006'),
('pass7', 'Chris', 'Anderson', 'chris@example.com', '2000-07-07', 'male', 'pic7.jpg', '01000000007'),
('pass8', 'Sara', 'Moore', 'sara@example.com', '2000-08-08', 'female', 'pic8.jpg', '01000000008'),
('pass9', 'David', 'Jackson', 'david@example.com', '2000-09-09', 'male', 'pic9.jpg', '01000000009'),
('pass10', 'Laura', 'Martin', 'laura@example.com', '2000-10-10', 'female', 'pic10.jpg', '01000000010'),
-- Teachers (uid 11-20)
('pass11', 'Alice', 'King', 'alice@example.com', '1985-01-01', 'female', 'pic11.jpg', '01000000011'),
('pass12', 'Bob', 'Lee', 'bob@example.com', '1986-02-02', 'male', 'pic12.jpg', '01000000012'),
('pass13', 'Cathy', 'Wong', 'cathy@example.com', '1987-03-03', 'female', 'pic13.jpg', '01000000013'),
('pass14', 'Dan', 'Kim', 'dan@example.com', '1988-04-04', 'male', 'pic14.jpg', '01000000014'),
('pass15', 'Ella', 'Clark', 'ella@example.com', '1989-05-05', 'female', 'pic15.jpg', '01000000015'),
('pass16', 'Frank', 'Lewis', 'frank@example.com', '1983-06-06', 'male', 'pic16.jpg', '01000000016'),
('pass17', 'Grace', 'Hall', 'grace@example.com', '1984-07-07', 'female', 'pic17.jpg', '01000000017'),
('pass18', 'Henry', 'Allen', 'henry@example.com', '1982-08-08', 'male', 'pic18.jpg', '01000000018'),
('pass19', 'Ivy', 'Young', 'ivy@example.com', '1981-09-09', 'female', 'pic19.jpg', '01000000019'),
('pass20', 'Jack', 'Scott', 'jack@example.com', '1980-10-10', 'male', 'pic20.jpg', '01000000020');
INSERT INTO student (sid, acad_year) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 2),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 2);
INSERT INTO teacher (tid, auth_doc, rating) VALUES
(11, 'auth_doc1.pdf', 8.5),
(12, 'auth_doc2.pdf', 7.8),
(13, 'auth_doc3.pdf', 9.0),
(14, 'auth_doc4.pdf', 7.5),
(15, 'auth_doc5.pdf', 8.0),
(16, 'auth_doc6.pdf', 8.3),
(17, 'auth_doc7.pdf', 9.1),
(18, 'auth_doc8.pdf', 7.2),
(19, 'auth_doc9.pdf', 8.6),
(20, 'auth_doc10.pdf', 7.9);
INSERT INTO course (tid, cname, description, cyear, semester, rating, subject, price) VALUES
(11, 'Math 101', 'Intro Math', 1, 'Fall', 8.5, 'Math', 99.99),
(12, 'Physics 101', 'Intro Physics', 1, 'Spring', 8.0, 'Physics', 120.00),
(13, 'Chemistry 101', 'Intro Chemistry', 1, 'Fall', 7.5, 'Chemistry', 115.00),
(14, 'Biology 101', 'Intro Biology', 1, 'Spring', 8.2, 'Biology', 110.00),
(15, 'Programming 101', 'CS Basics', 1, 'Fall', 9.0, 'CS', 150.00),
(16, 'History 101', 'World History', 1, 'Spring', 7.8, 'History', 80.00),
(17, 'Art 101', 'Intro to Art', 1, 'Fall', 8.9, 'Art', 75.00),
(18, 'Economics 101', 'Microeconomics', 2, 'Spring', 8.3, 'Economics', 90.00),
(19, 'Literature 101', 'English Literature', 1, 'Fall', 8.6, 'English', 85.00),
(20, 'Psychology 101', 'Intro Psychology', 1, 'Spring', 7.7, 'Psychology', 95.00),
(11, 'Statistics 101', 'Intro Statistics', 1, 'Fall', 8.4, 'Statistics', 88.00),
(12, 'Environmental 101', 'Environment Basics', 1, 'Spring', 7.9, 'Environment', 92.00);
-- Insert 12 sections linked to different courses
INSERT INTO section (cid, sec_order) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1);
-- Insert 20 objects across different sections
INSERT INTO object (secid, type, title, description, weight, o_order) VALUES
(1, 'uploaded_file', 'Lecture 1 File', 'PDF notes for Lecture 1', 1.0, 1),
(1, 'uploaded_file', 'Lecture 2 File', 'PDF notes for Lecture 2', 1.0, 2),
(2, 'uploaded_file', 'Physics Intro File', 'PDF notes for Physics', 1.0, 1),
(3, 'uploaded_file', 'Chemistry Intro File', 'PDF notes for Chemistry', 1.0, 1),
(4, 'uploaded_file', 'Biology Intro File', 'PDF notes for Biology', 1.0, 1),

(5, 'textbox', 'Introduction Text', 'Welcome to the course!', 1.0, 1),
(6, 'textbox', 'Physics Text', 'Basics of motion.', 1.0, 1),
(7, 'textbox', 'Chemistry Text', 'Basics of atoms.', 1.0, 1),
(8, 'textbox', 'Biology Text', 'Basics of cells.', 1.0, 1),
(9, 'textbox', 'Programming Text', 'Hello World program.', 1.0, 1),

(10, 'video', 'Intro Video', 'Introduction to the course.', 1.0, 1),
(11, 'video', 'Physics Video', 'Motion explained.', 1.0, 1),
(12, 'video', 'Chemistry Video', 'Atoms explained.', 1.0, 1),
(10, 'video', 'Biology Video', 'Cells explained.', 1.0, 1),
(11, 'video', 'Programming Video', 'First program run.', 1.0, 1),

(5, 'exercise', 'Math Quiz', 'Basic math exercises.', 1.0, 2),
(6, 'exercise', 'Physics Quiz', 'Basic physics exercises.', 1.0, 2),
(7, 'exercise', 'Chemistry Quiz', 'Basic chemistry exercises.', 1.0, 2),
(8, 'exercise', 'Biology Quiz', 'Basic biology exercises.', 1.0, 2),
(9, 'exercise', 'Programming Quiz', 'Basic programming exercises.', 1.0, 2);
-- Insert uploaded files
INSERT INTO uploaded_file (fid, binary_file) VALUES
(1, 'math1.pdf'),
(2, 'math2.pdf'),
(3, 'physics1.pdf'),
(4, 'chem1.pdf'),
(5, 'bio1.pdf');
-- Insert textboxes
INSERT INTO textbox (tbid, content) VALUES
(6, 'This is the course introduction.'),
(7, 'Physics concepts explained here.'),
(8, 'Introduction to Chemistry here.'),
(9, 'Biology basics introduction.'),
(10, 'Programming basics explained.');
-- Insert videos
INSERT INTO video (vid, link) VALUES
(11, 'https://youtu.be/intro_course'),
(12, 'https://youtu.be/physics_intro'),
(13, 'https://youtu.be/chem_intro'),
(14, 'https://youtu.be/bio_intro'),
(15, 'https://youtu.be/programming_intro');
-- Insert exercises
INSERT INTO exercise (eid, marks) VALUES
(16, 10.0),
(17, 8.0),
(18, 9.5),
(19, 7.0),
(20, 9.0);
-- Insert student finishes with grades
INSERT INTO finish (sid, oid, grade) VALUES
(1, 1, 8.0),  -- Student 1 finishes object 1 (uploaded_file)
(1, 6, 7.5),  -- Student 1 finishes object 6 (textbox)
(1, 11, 9.0), -- Student 1 finishes object 11 (video)
(2, 2, 6.5),  -- Student 2 finishes object 2 (uploaded_file)
(2, 7, 8.5),  -- Student 2 finishes object 7 (textbox)
(2, 12, 8.0), -- Student 2 finishes object 12 (video)
(3, 3, 9.0),  -- Student 3 finishes object 3 (uploaded_file)
(3, 8, 7.0),  -- Student 3 finishes object 8 (textbox)
(3, 13, 8.5), -- Student 3 finishes object 13 (video)
(4, 4, 7.5),  -- Student 4 finishes object 4 (uploaded_file)
(4, 9, 8.0),  -- Student 4 finishes object 9 (textbox)
(4, 14, 9.5), -- Student 4 finishes object 14 (video)
(5, 5, 6.0),  -- Student 5 finishes object 5 (uploaded_file)
(5, 10, 8.0), -- Student 5 finishes object 10 (textbox)
(5, 15, 7.0), -- Student 5 finishes object 15 (video)
(6, 16, 9.0), -- Student 6 finishes object 16 (exercise)
(6, 17, 7.5), -- Student 6 finishes object 17 (exercise)
(7, 18, 8.5), -- Student 7 finishes object 18 (exercise)
(7, 19, 7.0), -- Student 7 finishes object 19 (exercise)
(8, 20, 9.5); -- Student 8 finishes object 20 (exercise)
-- Insert student enrollments with course ratings
INSERT INTO enroll (sid, cid, rating) VALUES
(1, 1, 8.0),  -- Student 1 enrolls in course 1
(1, 2, 7.5),  -- Student 1 enrolls in course 2
(2, 3, 9.0),  -- Student 2 enrolls in course 3
(2, 4, 7.0),  -- Student 2 enrolls in course 4
(3, 5, 8.5),  -- Student 3 enrolls in course 5
(3, 6, 7.5),  -- Student 3 enrolls in course 6
(4, 7, 8.0),  -- Student 4 enrolls in course 7
(4, 8, 7.0),  -- Student 4 enrolls in course 8
(5, 9, 6.5),  -- Student 5 enrolls in course 9
(5, 10, 9.0), -- Student 5 enrolls in course 10
(6, 11, 7.5), -- Student 6 enrolls in course 11
(7, 1, 9.0),  -- Student 7 enrolls in course 1
(7, 2, 8.0),  -- Student 7 enrolls in course 2
(8, 3, 7.5),  -- Student 8 enrolls in course 3
(8, 4, 6.5),  -- Student 8 enrolls in course 4
(9, 5, 8.5),  -- Student 9 enrolls in course 5
(9, 6, 7.0),  -- Student 9 enrolls in course 6
(10, 7, 8.0), -- Student 10 enrolls in course 7
(10, 8, 9.0); -- Student 10 enrolls in course 8
-- Insert student reviews for courses
INSERT INTO review (cid, sid, rating, content) VALUES
(1, 1, 8.0, 'Great course, but could use more examples.'),
(2, 1, 7.5, 'Interesting, but some sections were unclear.'),
(3, 2, 9.0, 'Fantastic! The material was well-structured and clear.'),
(4, 2, 7.0, 'Good course, but some topics were repetitive.'),
(5, 3, 8.5, 'I really enjoyed it, but it could be more interactive.'),
(6, 3, 7.5, 'Nice course, but the pace was too slow for me.'),
(7, 4, 8.0, 'The course was solid, but the assignments were difficult.'),
(8, 4, 7.0, 'It was okay, but I expected more practical exercises.'),
(9, 5, 6.5, 'The course had some useful info but needs more depth.'),
(10, 5, 9.0, 'Excellent course, very engaging and well-paced.'),
(1, 6, 7.5, 'Good course, but a bit too theoretical for my liking.'),
(2, 7, 9.0, 'Amazing content! Learned a lot from this course.'),
(3, 7, 8.0, 'Great, but I would like more real-world applications.'),
(4, 8, 8.5, 'Solid course, I gained valuable insights.'),
(5, 8, 6.5, 'The course was alright, but I struggled with some parts.'),
(6, 9, 8.0, 'Great course, but it lacked interactive elements.'),
(7, 9, 9.0, 'Really enjoyed the material and delivery.'),
(8, 10, 7.5, 'Good, but needs more case studies and practical examples.'),
(9, 10, 8.5, 'Well-rounded course, would recommend to others.'),
(10, 10, 9.0, 'Excellent! One of the best courses I have taken.');

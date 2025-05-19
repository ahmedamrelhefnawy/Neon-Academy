create database Neuracademy

use Neuracademy

create table app_user(
	uid int not null identity(1,1),
	password varchar(50)not null,
	fname varchar(20) not null,
	lname varchar(20) not null,
	email varchar(100) not null,
	dob date,
	gender varchar(7) CHECK (LOWER(gender) IN ('male', 'female')),
	picture VARBINARY(max),
	phone varchar(11) unique,
	primary key (uid)
	);

create table student(
	sid int not null,
	acad_year int CHECK (acad_year > 0),
	foreign key (sid) references app_user(uid) ON DELETE CASCADE,
	primary key (sid)
	);

create table teacher(
	tid int not null,
	auth_doc VARBINARY(max),
	rating decimal(3,1) CHECK (rating BETWEEN 0 AND 10),
	foreign key (tid) references app_user(uid) ON DELETE CASCADE,
	primary key (tid)
	);
create table course(
	cid int not null identity(1,1),
	tid int,
	cname varchar(30) not null, 
	description varchar(150),
	cyear int CHECK (cyear > 0),
	semester varchar(10),
	creation_date date DEFAULT CAST(GETDATE() AS date),
	rating decimal(3,1) CHECK (rating BETWEEN 0 AND 10),
	subject varchar(15),
	price decimal(9,3) CHECK (price >= 0),
	foreign key (tid) references teacher(tid),
	primary key (cid)
	);
create table section(
	secid int not null identity(1,1),
	cid int not null,
	sec_order int,
	foreign key (cid) references course(cid) ON DELETE CASCADE,
	primary key (secid)
	);
create table object(
	oid int not null identity(1,1),
	secid int not null,
	type varchar(20),
	title varchar(50),
	description varchar(150),
	creation_date date DEFAULT CAST(GETDATE() AS date),
	weight decimal(3,1) CHECK (weight >= 0),
	o_order int,
	foreign key (secid) references section(secid) ON DELETE CASCADE,
	primary key (oid)
	);
create table uploaded_file(
	fid int not null,
	binary_file VARBINARY(max),
	foreign key (fid) references object(oid) ON DELETE CASCADE,
	primary key (fid)
	);
create table textbox(
	tbid int not null,
	content varchar(150),
	foreign key (tbid) references object(oid) ON DELETE CASCADE,
	primary key (tbid)
	);
create table video(
	vid int not null,
	link varchar(150),
	foreign key (vid) references object(oid) ON DELETE CASCADE,
	primary key (vid)
	);
create table exercise(
	eid int not null,
	marks decimal(3,1) CHECK (marks >= 0),
	foreign key (eid) references object(oid) ON DELETE CASCADE,
	primary key (eid)
	);
create table question(
	qid int not null identity(1,1),
	content varchar(150) not null,
	primary key (qid)
	);
create table mcq(
	qid int not null,
	op1 varchar(50),
	op2 varchar(50),
	op3 varchar(50),
	op4 varchar(50),
	answer varchar(50) not null,
	foreign key (qid) references question(qid) ON DELETE CASCADE,
	primary key (qid)
	);
create table writing(
	qid int not null,
	answer varchar(200) not null,
	foreign key (qid) references question(qid) ON DELETE CASCADE,
	primary key (qid)
	);
create table ex_qn(
	eid int not null,
	qid int not null,
	foreign key (eid) references exercise(eid) ON DELETE CASCADE,
	foreign key (qid) references question(qid) ON DELETE CASCADE,
	primary key (eid,qid)
	);

create table finish(
	sid int not null,
	oid int not null,
	grade decimal(3,1) CHECK (grade >=0), 
	foreign key (sid) references student(sid) ON DELETE CASCADE,
	foreign key (oid) references object(oid) ON DELETE CASCADE,
	primary key (sid,oid)
	);
create table enroll(
	sid int not null,
	cid int not null,
	rating decimal(3,1) CHECK (rating BETWEEN 0 AND 10),
	foreign key (sid) references student(sid) ON DELETE CASCADE,
	foreign key (cid) references course(cid) ON DELETE CASCADE,
	primary key (sid,cid)
	);
create table review(
	rid int not null identity(1,1),
	cid int not null,
	sid int not null,
	rating decimal(3,1) CHECK (rating BETWEEN 0 AND 10),
	content varchar(150),
	rdate date DEFAULT CAST(GETDATE() AS date),
	foreign key (cid) references course(cid) ON DELETE CASCADE,
	foreign key (sid) references student(sid),
	primary key (rid)
	);

drop database if exists task_management;
create database task_management;
use task_management;

 

create table app_user (
    app_user_id int primary key auto_increment,
    first_name text not null,
    last_name text not null,
    username varchar(50) not null unique,
    password_hash varchar(2048) not null,
    enabled bit not null default(1)
);

 

create table app_role (
    app_role_id int primary key auto_increment,
    `name` varchar(50) not null unique
);

 
create table app_user_role (
    app_user_id int not null,
    app_role_id int not null,
    constraint pk_app_user_role
        primary key (app_user_id, app_role_id),
    constraint fk_app_user_role_user_id
        foreign key (app_user_id)
        references app_user(app_user_id),
    constraint fk_app_user_role_role_id
        foreign key (app_role_id)
        references app_role(app_role_id)
);

 

create table project (
    project_id int primary key auto_increment,
    name text not null
);

 

create table task (
    task_id int primary key auto_increment,
    project_id int not null,
	title text not null,
    description text not null,
    created_at date not null,
    priority text not null,
    created_by text not null,
    deadline date not null,
    status text not null,
     constraint fk_task_project_id
        foreign key (project_id)
        references project(project_id)
   
);

create table task_assignment (
    taskassignment_id int primary key auto_increment,
	task_id int not null,
    app_user_id int not null,
    assigned_at date not null,
    completed_at date not null,
    notes text not null,
     constraint fk_task_assignment_task_id
        foreign key (task_id)
        references task(task_id),
   constraint fk_task_assignment_app_user_id
        foreign key (app_user_id)
        references app_user(app_user_id)
);


insert into app_role (`name`) values
    ('USER'),
    ('ADMIN');

 

-- passwords are set to "P@ssw0rd!"
insert into app_user (first_name, last_name, username, password_hash, enabled)
    values
  ('John', 'Smith', 'john@smith.com', '$2a$10$ntB7CsRKQzuLoKY3rfoAQen5nNyiC/U60wBsWnnYrtQQi8Z3IZzQa', 1),
  ('Sally', 'Jones', 'sally@jones.com', '$2a$10$ntB7CsRKQzuLoKY3rfoAQen5nNyiC/U60wBsWnnYrtQQi8Z3IZzQa', 1);

 
 insert into app_user_role
    values
    (1, 2),
    (2, 1);


-- Insert fake data into the project table
INSERT INTO project (name) VALUES
    ('Project A'),
    ('Project B'),
    ('Project C');

-- Insert fake data into the task table
INSERT INTO task (project_id, title, description, created_at, priority, created_by, deadline, status) VALUES
    (1, 'Task 1', 'Description for Task 1', '2023-09-20', 'High', 'John Doe', '2023-09-25', 'Incomplete'),
    (1, 'Task 2', 'Description for Task 2', '2023-09-21', 'Medium', 'Alice Smith', '2023-09-27', 'Incomplete'),
    (2, 'Task 3', 'Description for Task 3', '2023-09-22', 'Low', 'Bob Johnson', '2023-09-28', 'Incomplete');

-- Insert fake data into the task_assignment table
INSERT INTO task_assignment (task_id, app_user_id, assigned_at, completed_at, notes) VALUES
    (1, 1, '2023-09-20', '2023-09-24', 'Completed by John'),
    (1, 2, '2023-09-21', '2023-09-25', 'Completed by Alice'),
    (2, 2, '2023-09-22', '2023-07-12', 'Assigned to Alice'),
    (3, 1, '2023-09-22', '2023-06-05', 'Assigned to Bob');

 
-- drop table if exists app_user_role;
-- drop table if exists app_role;
-- drop table if exists app_user;
-- DROP TABLE task_assignment;
-- DROP TABLE task;
-- DROP TABLE project;


select * from app_user;
select * from app_user_role;
select * from app_role;
select * from project;
select * from task;
select * from task_assignment;


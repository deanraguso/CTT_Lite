# Calendar Task Tracker - Lite
#### Dean Raguso

## Source Control
https://github.com/deanraguso/CTT_Lite

## Project Management
https://www.pivotaltracker.com/n/projects/2494756

## Basic Structure
- Session Class: Main application managing object, with menus and redirection.
- Task Class: Holds the task information, id, creator, etc.
- TaskManager Class: Manages the saving of tasks, all configuration, instanced once per session.
- Calendar Class: Uses the task manager in addition to it's own logic to arrange and display tasks in conjunction with system date.
- User Class: Holds username, password (eventually encryption methods), a unique id, etc.
- UserManager Class: Manages the database of users, holds the methods for logging in, creating and editting accounts etc.

## Purpose
This application allows for scheduling and tracking your tasks within the command line.

- User Authorization: Login/Logout/Create_Account
- CRUD Tasks: Task_Name/Description/Importance/Urgency/Time_Required/Due_Date
- Calendar Scheduling: Print_Calendar[Days]/Balance_Schedule



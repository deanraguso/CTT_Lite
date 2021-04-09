# Calendar Task Tracker - Lite
#### <em>Dean Raguso</em>

## Installation
#### Requirements
- ruby >= 2.7.2
- Active Internet Connection on Installation.
- memory ~ 2Mb
 
#### Steps
1. Git clone the <a href="https://github.com/deanraguso/CTT_Lite">repository</a> (link below)
2. Open Terminal in Project folder.
3. Rundle Bundle Install for dependencies.
4. To launch application, type "./ctt.sh" in command line. (or "./ctt.sh -h" for basic help)

## Source Control
https://github.com/deanraguso/CTT_Lite

## Project Management
The implementation plan was created and exists publicly using <b>Piviotol Tracker.</b>
https://www.pivotaltracker.com/n/projects/2494756

## Purpose
This application allows for scheduling and tracking your tasks within the command line.

### Features
- User Authorization with encryption: Login/Logout/Create_Account
- CRUD Task Functionality: Create/Update/Update/Destroy tasks.
- Calendar Scheduling: Print and Optimise Calendar of tasks.

### Scope
This project is limited to the command line, with the features specified above. It may be updated to be more clean, user friendly or functional, but won't turn into an online or GUI application at any stage.

### User Interaction
1. You start the application by running the executable.
   1. ./ctt.sh
2. You are now on the user sign-in screen.
   1. If you are new, create an account.
   2. If you already have an account, choose "sign in".
3. You are now on the main menu.
   1. If you are new, the only Task option you will see is New Task.
   2. If you have already made a Task, you will also have the options to Edit, Delete or Show a task.
   3. If you have already made a Task, you can also select Print Calendar or Optimise Calendar.
   4. If you navigate down, you can sign out, which takes you back to the sign-in screen.
   5. If you navigate one below sign out, you can select exit, to close the application.

<img src="/docs/Flowchart.jpg">

### Basic Structure
- Session Class: Main application managing object, with menus and redirection.
- Task Class: Holds the task information, id, creator, etc.
- TaskManager Class: Manages the saving of tasks, all configuration, instanced once per session.
- Calendar Class: Uses the task manager in addition to it's own logic to arrange and display tasks in conjunction with system date.
- Schedule Class: Holds the current task items, varies in size depending on Calendar requirements.
- User Class: Holds username, password (eventually encryption methods), a unique id, etc.
- UserManager Class: Manages the database of users, holds the methods for logging in, creating and editting accounts etc.

## Resources
- rspec - https://rubygems.org/gems/rspec
- rspec-core - https://rubygems.org/gems/rspec-core
- tty-prompt - https://rubygems.org/gems/tty-prompt
- bcrypt - https://rubygems.org/gems/bcrypt
- byebug - https://rubygems.org/gems/byebug
- ascii-charts - https://rubygems.org/gems/ascii-charts/versions/0.9.2

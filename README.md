   														Installation for Linux
1.First,download Python 2.7 from the official Website(It comes already installed with Linux.In case it is not       installed,install it)

2.----Checking for version----
     Open terminal and enter

$ python

     it must show the version of Python e.g. Python 2.7.11


2.----Downloading project from github----
   Clone or Download the zip file and unzip the project file and put the file in your preffered directory.

3.----Creating Virtual Environment----
     a.First, run --> 
	
$ sudo pip install virtualenv.

     b.Open terminal and go to the project directory.Now enter --> 

$ virtualenv <VirtualEnvName>
 
        it will create a virtual environment for your project. e.g. virtualenv ve
     c.Now for activating the virtual environment,type -->
	
$ source <VirtualEnvName>/bin/activate

          e.g.$ source venv/bin/activate
4.----Download the dependencies----
      
	a.In command line,go to your project directory,then type 'cd connect_eko' then press enter,now check file list using ls ,you must see requirements.txt.
	b.Now run the command 
    
$ pip install -r requirements.txt

        (It will automatically install all the requirements needed)
    If in any case, any package can't be downloaded the download it separately.    

 
5.----Setting up the database (We assume you have preinstalled mysql)----------

	a. Create a database in mysql by running the query

mysql> CREATE DATABASE <database-name>;  

	b.Now go to project folder then inside connect_eko open the file 'dev.py'.
	c.Set the 'NAME','USER' and 'PASSWORD'.
     

We have provided a dummy database, you can edit it and make it yours. 
---TO USE OUR DUMMY DATABASE---
	
	d. Get to the location of 'connect_demo.sql' (dummy database) and open the terminal and type

$ mysql -u <username> -p 
mysql> use <database name>;
mysql> source connect_demo.sql;
mysql> exit;

	e. Now run the server in the project folder by entering-

$python manage.py runserver     

    h. Open the browser & type 

localhost:<port_no>/admin

       	Now populate the databases & change accordingly.

6.The portal will start running at localhost:8000 by default.        
   


   									
### Installation instructions for Linux
1. Linux comes with pre-installed python 2.7.If python is not installed in your system, download python 2.7 and install it.

2. To check version of python installed
  ```sh
  $ python
  ```
  e.g. `Python 2.7.11`

3. Download the project from github.
  - Clone or Download the zip file.
  - Unzip the file and place it in your preferred directory.

4. Create Virtual Environment
  - Run
   ```sh	
   $ sudo pip install virtualenv.
   ```
  - Go to the project directory. To create virtual environment for your project
   ```sh
   $ virtualenv <VirtualEnvName>
   ``` 
	   e.g.`$ virtualenv ve`
  - To activate the created environment
   ```sh
   $ \source\ <VirtualEnvName>/bin/activate
   ```
	   e.g.`$ source venv/bin/activate`
   
5. Download the dependencies
  - In project directory "connect_eko", find "requirements.txt" file
  - Now run the command `$ pip install -r requirements.txt`
    (It will automatically install all the requirements needed).
    If any package couldn't be downloaded, then download it separately.

6. Setting up the database (We assume you have preinstalled mysql)
  - Create a database in mysql by running the query `mysql> CREATE DATABASE <database-name>;`
  - Find 'dev.py' file in `connect_eko/settings/`
  - Set the 'NAME','USER' and 'PASSWORD'.
  - We have provided a dummy database, you can edit it and make it yours. 
  - To use our dummy database, get to the location of 'connect_eko_demo.sql' (dummy database) and open the terminal and type
   ```sh
   $ mysql -u <username> -p 
   mysql> use <database name>;
   mysql> source connect_demo.sql;
   mysql> exit;
   ```
  - Now run the server in the project folder `$python manage.py runserver`
  - Open your browser and visit `localhost:8000/admin`. Now populate the databases & change accordingly.

7. The portal will start running at `localhost:8000` by default. For login, use following credentials:
  
  Username: `6726152721`
  Password: `sample@123`

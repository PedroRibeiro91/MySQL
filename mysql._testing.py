import datetime
import mysql.connector

db = mysql.connector.connect(
    host = "localhost",
    user = "Pedro",
    passwd = "1410",
    database = "mydatabase"
)
myCursor = db.cursor()

# myCursor.execute("CREATE DATABASE mydatabase")

# basic queries / commands

# myCursor.execute("""CREATE TABLE Person (name VARCHAR(50), age smallint UNSIGNED,
#                personID int PRIMARY KEY AUTO_INCREMENT )""")

# in this table we take a persons name which is a character variable up to a length of 50 VARCHAR(50)
# age in a smallint format because age is usually 2 digit number (3 maybe) and theres no need to use much memory
# to save it, age doesn't need to care for a signal because we don't use "negative age count"
# personID will be on a regular integer format and will be a primary key which means each person will have their
# unique ID and this helps to differentiate similar entries like 2 people with the same name and age, for example.

# now, lets take a look what what we did

# myCursor.execute("DESCRIBE Person")
# for field in myCursor:
   # print(field)

# Insert elements into our table
# myCursor.execute("INSERT INTO Person (name,age) VALUES (%s,%s)", ("Pedro", 28))
# commit our entry to the table
# db.commit()

# lets see the items in our table

# myCursor.execute("SELECT * FROM Person")

# for item in myCursor:
  # print(item)

# lets add another person to the table and run the above code and check that a primary key was given to our new entry

# myCursor.execute("INSERT INTO Person (name,age) VALUES (%s,%s)", ("Mario", 29))
# db.commit()

# lets create a new table

# myCursor.execute("""CREATE TABLE Clients (name VARCHAR(50) NOT NULL, created datetime,
# gender ENUM('M', 'F', 'O') NOT NULL, id int PRIMARY KEY NOT NULL AUTO_INCREMENT)""")

# again lets insert some items

# myCursor.execute("INSERT INTO Clients (name, created, gender) VALUES (%s,%s,%s)", ("Bruno", datetime.datetime.now(), "M"))
# db.commit()

# Now lets access to elements in our table

# myCursor.execute("SELECT * FROM Clients WHERE gender = 'M' ORDER BY id DESC")
# for client in myCursor:
   # print(client)

# another example
# myCursor.execute("SELECT id, name FROM Clients WHERE gender = 'M' ORDER BY id DESC")
# for client in myCursor:
   # print(client)

# modify our table by adding a column
# myCursor.execute("ALTER TABLE Clients ADD COLUMN sport VARCHAR(50) NOT NULL ")
# lets again see how our table looks
# myCursor.execute("DESCRIBE Clients")
# for field in myCursor:
   # print(field)

# modify our table clients by removing a column: we came to the conclusion that
# we dont need to know what sports our clients practice, because we dont sell sports items

#myCursor.execute("ALTER TABLE Clients DROP sport")
# and again confirm this change
# myCursor.execute("DESCRIBE Clients")
# for field in myCursor:
  # print(field)

# now as we saw our clients provided us with only one name so we will change the name of the column "name" to
# "first_name"

# myCursor.execute("ALTER TABLE Clients CHANGE name first_name VARCHAR(50)")
# lets check it
# myCursor.execute("DESCRIBE Clients")
# for field in myCursor:
 # print(field)


# lets make it "harder"

users = [("Pedro", "12324"),
        ("Rita", "asdf"),
        ("Monica", "zxcvb")]

userScore = [(69,100), (100,100), (99,100)]

myCursor = db.cursor()

# we can attribute queries to variables like shown below and then ask the cursor to execute
# Q1 = "CREATE TABLE Users (id int PRIMARY KEY AUTO_INCREMENT, name VARCHAR(50), passwd VARCHAR(50))"

# Q2 = """CREATE TABLE Scores (userId int PRIMARY KEY, FOREIGN KEY(userId) REFERENCES Users(id),
# game1 int DEFAULT 0, game2 int DEFAULT 0)"""
# we want to assign the id on the table Users to userId on the table Scores

# myCursor.execute(Q1)
# myCursor.execute(Q2)

# lets check out tables
# myCursor.execute("SHOW TABLES")
# for table in myCursor:
 # print(table)

# now lets add to our tables the respective entries

# Q3 = "INSERT INTO Users (name,passwd) VALUES (%s,%s)"

# Q4 = "INSERT INTO Scores (userId, game1,game2) VALUES (%s,%s,%s)"

#for u, user in enumerate(users):
#    myCursor.execute(Q3, user)
#    last_id = myCursor.lastrowid
#    myCursor.execute(Q4, (last_id,) + userScore[u])
# db.commit()

# look at the table Users
# myCursor.execute("SELECT * FROM Users")
#for user in myCursor:
#    print(user)

# look at the table scores
#myCursor.execute("SELECT * FROM Scores")
#for score in myCursor:
#    print(score)

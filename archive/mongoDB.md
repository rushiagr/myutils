# Mongo DB - A Quick Start

Shortest intro to Mongo DB: A (nearly a) database, in which rows of a table are stored as a Python dictionary objects. You might have guessed that I'm going to talk about MongoDB mostly in close association with Python.

## Installing MongoDB on Ubuntu

Run all commands as root.


Import this GPG key (Just do it if you don't know what it means)
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
```

Create this file: `/etc/apt/sources.list.d/10gen.list`, and then add this
one single line to that file:
```
/etc/apt/sources.list.d/10gen.list
```
Just want to copy paste? Get it here:
```
echo "/etc/apt/sources.list.d/10gen.list" > /etc/apt/sources.list.d/10gen.list
```

Update package list
```
apt-get update
```

Install latest MongoDB
```
apt-get install mongodb-10gen
```

Start the MongoDB service. (Just replace `start` with `stop` or `restart` to carry out the corresponding action)
```
service mongodb start
```

Another test of character

	Service mongodb start


Now start the database console
```
mongo
```
Which will display something like this:
```
root@ubuntu:~# mongo
MongoDB shell version: 2.4.3
connecting to: test
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	http://docs.mongodb.org/
Questions? Try the support group
	http://groups.google.com/group/mongodb-user
>
```

(If you are finding troubles setting this up, look up here `http://blog.brianbuikema.com/2011/01/mongodb-ubunto-overview-installation-setup-dev-python-2/`, and also check in the log file if you have enough free space on your disk, which the prompt curiously told me is around 4GBs!)

## Database simple operations
OK, so remember, MongoDB is a sort of database 'management system', and you will create databases inside it, which will hold tables, much like MySQL if you are familiar with it.

Create a DB to hold tables
```
> use personalinfo
switched to db mydb
```

See which DB you are currently into
```
> db
personalinfo
```



Create a table `bloodgroup`, and add a guy's bloodgroup to it:
```
db.bloodgroup.insert({'rushi': 'B'})
```

See <database>.<tablename> for this table:
```
> db.bloodgroup
personalinfo.bloodgroup
```

See the items in the table:
```
> db.bloodgroup.find()
{ "_id" : ObjectId("517ae0681f00f1f8768c3b07"), "rushi" : "B" }
```

You can see, the database inserted a unique ID as a key-value pair for this row in the table.

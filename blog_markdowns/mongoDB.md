# Mongo DB - A Quick Start

Shortest intro to Mongo DB: A (nearly a) database, in which rows of a table are stored as a Python dictionary objects. You might have guessed that I'm going to talk about MongoDB mostly in close association with Python.

## Installing MongoDB on Ubuntu

Run all commands as root.


Import this GPG key (Just do it if you don't know what it means)
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

Create this file: `/etc/apt/sources.list.d/10gen.list`, and then add this
one single line to that file:
```    /etc/apt/sources.list.d/10gen.list
```
Just want to copy paste? Get it here:
	echo "/etc/apt/sources.list.d/10gen.list" > /etc/apt/sources.list.d/10gen.list

Update package list
    apt-get update

Install latest MongoDB
    apt-get install mongodb-10gen

Start the MongoDB service. (Just replace `start` with `stop` or `restart` to carry out the corresponding action)
    service mongodb start

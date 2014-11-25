# 1. Collecting scrabble data

In this step we will explain how to fetch Scrabble games from the Internet
Scrabble Club server and store these in a PostgreSQL database.

## 1.1a Quick start

The fastest way to get started is to import
[this database dump](http://cl.ly/code/3Y1U3b1B263o/download/internet_scrabble_club.sql).
It contains about 55.000 moves and can be imported using the following commands:

```bash
createdb internet_scrabble_club
psql -d internet_scrabble_club -f internet_scrabble_club.sql
```

## 1.1b Alternative way

Alternatively, the scripts in this directory can be used to fetch the data
yourself. In order to do so, an Internet Scrabble Club account needs to be
created. This can be done here: http://www.isc.ro/en/registration.html.

Furthermore it is assumed that a PostgreSQL database named
`internet_scrabble_club` exists. The required tables will be created
automatically.

The following commands will start programs that collect data from the Internet
Scrabble Club server.

```bash
bundle exec rake players:scrape NICKNAME=<nickname> PASSWORD=<password>
```

```bash
bundle exec rake games:scrape NICKNAME=<nickname> PASSWORD=<password>
```

By executing the first command, nicknames of Scrabble players will be collected
and stored in the database. The program can be terminated by pressing
<kbd>Control</kbd>+<kbd>C</kbd> once enough nicknames are collected.

The second command retrieves the latest ten games and their corresponding moves
for all of the collected Scrabble players. The program will terminate once there
are no more games to retrieve.

## 1.2 Summarizing the data

A summary of the collected data can be view by issuing the following command:

```bash
bundle exec rake summarize
```

The output will look something like this:

```
Player metrics
========================================
Total                               1605
----------------------------------------

Game metrics
========================================
Total                               1726
----------------------------------------

Turn metrics
========================================
Moves                              55282
Passes                              2607
Exchanges                           2081
Total                              59970
----------------------------------------
```


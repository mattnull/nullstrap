# NullStrap
## A CoffeeScript / Express.js bootstrap

### Features

* Cakefile for a single command install and dev setup
* Watches folders for Stylus, CoffeeScript, and Handlebars changes
* Bower support for easily adding client-side dependencies

====================

## Technologies

* Express.js - http://expressjs.com/
* Bower - http://twitter.github.com/bower/
* Jade - http://jade-lang.com/
* Handlebars - http://handlebarsjs.com/
* CoffeeScript - http://coffeescript.org/

## Dependencies

This command needs to be ran first if CoffeeScript is not installed on your system

run `sudo npm install -g coffee-script` in Terminal

## Setup

Install all of the dependencies necessary for the bootstrap

run `sudo cake install` in Terminal

## Development

The following command will watch and compile Coffeescript and Stylus files. It runs server.js using Supervisor.

run `cake dev` in Terminal

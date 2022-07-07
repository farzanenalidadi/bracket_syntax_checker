# log_parser_master
![](public/ruby_version.svg)
![](public/rubocop.svg)
![](public/coverage.svg)

This is Ruby application help to you to know the expression is valid parentheses or not.This app handle single expression or multi line expression.

# Getting Start 
Although this program might work on older ruby versions,It has been developed using Ruby 2.7.0

To get started with the app, first clone the repository and cd into the directory:

```
$ git clone https://github.com/farzanenalidadi/bracket_syntax_checker.git 
$ cd bracket_syntax_checker
```
Then install the needed gems

```
$ bundle install 
```

Run from command line,You should go to bracket_syntax_checker directory

```
 ./checker.rb "expression" like "[()]"
```

# BracketChecker Test
For Run test you should run the command with `rspec` and you can see test coverage in test result 

For run Rubocop(static code analyzer) you should run the command with `rubocop`


# Roadmap 
* Docker Base Should be better for reduce dependency in local test, such `Ruby`  




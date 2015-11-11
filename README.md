pipes
=====

a data processing approach to building the web

"The internet is not just something you dump something on. It's not a big
truck. It's a series of tubes." - Senator Ted Stevens 

## Introduction

Programmers often see their program in terms of the data structures it
contains, and  to some extent what database structure it uses. Due to time
contraints and other constraints, projects often skimp on code quality and all
practices that might lead to code quality.

What if code was easier to reason about? What if testing were easy?

pipes aims to flip the script and say that looking at the world through the
lens of data structures is wrong, and instead we need to look at the ideas of
data processing as most of what we are doing is more about the process of data
transformation around a set of rules, than it is about the structures
themselves.

pipes is not MVC. In fact, there is no notion of models or entities in pipes at
all. It's just data and processing with just a small amount of orchestaration
up front.

## Structure

pipes is designed with a simple pluggable structure of three discrete parts - a
data pipeline, a data presenter, and a view. By default pipes is designed for
generating strings of HTML for the web, but that design choice does not mean
that it is by any means coupled to web technologies.

The best way to think of pipes is a data translation tool that turns some kind
of input hash into some kind of output string. What happens in the middle is
totally up to you.

### Routes

To begin with, in pipes you create a set of routes. Routes are defined as a
plain old ruby hash which for convention's sake are put in routes.rb. Keys are
strings and for now they take on this format `[GET] /make_something`

The format is the http verb in brackets followed by a space and the url after that.

This is what an entire route entry looks like:

    '[GET] /make_something' => {
        pipeline: :CreateUser,
        presenter: :GenericPresenter,
        view_engine: :GenericView,
        view_name: :create_user,
        params: [:name, :other]
    },

In that entry you define the pipeline, presenter, view engine, view name, and
what params to pass into the data pipeline.

For simplicity's sake, at this time pipes doesn't use pretty url's and we rely
on the default http params structures.

### Pipelines

In a given request, the pipeline you define in a route is the first step executed.

A data pipeline is something that takes input and returns a data structure that
gets passed along to a presenter. The role of a pipeline is to do the raw data
processing needed to fulfil a request. 

In general, a pipeline should be treated more as a function than as an object.
It should not contain local state and it should not be overloaded with multiple
responsiblilities.

Pipelines are made to be composed together as needed. Data should flow through
pipelines and they should act totally independant of one another unless they
are being used to connect other pipelines together.

In short, pipelines look like this input -> data transformation -> output.

A pipeline must return some form of output. For now it is using hashes, but in
the future, pipes might adopt a different data structure.


### Presenters

In a given request, the presenter you define in a route is the second step executed.

A data presenter is the second main data transformation step and in many ways
it is not that different than a pipeline. It follows the same principle of
input -> data transformation -> output. 

However, the role of a presenter is different than that of a pipeline. The role
of the presenter is to transform the final output of your data pipeline into a
format usable by a view.

This role is important because it allows you the flexability to structure your
view data in a way that makes sense for your view, and your other data in a way
that makes sense for your program or your database or whatever.

Your database data structures and your view data structures don't need to match at all.

Like pipelines, a presenter must return some form of output. For now it is 
using hashes, but in the future, pipes might adopt a different data structure.


### Views

In a given request, the view you define in a route is the last step executed.

A view is the last transformation step and it in most cases is going to inject
a bunch of data returned from your presenter into some kind of string template.

Again, the principle is input -> data transformation -> output, but instead of
outputting a hash of data, we are outputting a string of very probably HTML in
most cases where pipes is used.

A view does not have to return a HTML string, it can return whatever you want.
Other formats like JSON or XML might be appropriate for API based use cases.

A view only has access to the data the presenter returns. So, don't attempt to
call any other part of your program inside of a view. If you need some data in
a view that you don't have, you forgot to add it in either the presenter or the
data pipeline.

DO NOT MAKE ANY SORT OF DATA RETRIEVAL/PROCESSING CALLS IN THE VIEW OR PRESENTER!!!

## Frequently Asked Questions

**Why isn't this MVC?**

Well, not to get on my high horse, but MVC as it is often implemented is a tightly
coupled structure, and it is very often coupled to both the notion of a web request
and a database. Both pipes and your favorite MVC framework are soliving the same 
basic problem... turning some form of user input into some kind of output... usually 
a string of HTML. 

I see the concepts of data processing and transformation to be a better fit
for the web than the approach of data modeling as the central abstraction to solve
web app problems with. 

**Is pipes functional or object oriented?**

pipes is probably a bit of both. Most of the code in pipes should feel very
functional and it borrows heavily from functional concepts. While not
implemented in pipes yet, I have a strong design prefrence towards
immutability, plain data structures, and only complecting state and functions 
together when there is no better way to solve the problem.

**Does pipes have to be built in Ruby?**

Nope. pipes is built on top of ruby because that is the tool I have closest at hand. 

The purpose of pipes is to prove out an approach I have towards app development
that I think is a lot different than most frameworks.

Long term, I don't know if pipes will stay with ruby as ruby is missing some
features that would mkae pipes a lot easier to build with.

**Does pipes have an ORM?**

No. There are a lot of good reasons why pipes doesn't have an ORM. First, ruby already
has a few strong choices of ORM if you decide to go that route. Honestly, ORM's
are of limited use and should be treated as a shortcut to not have to write
SQL code. For anything more complex than a CRUD app, ORM's pollute your program
and make it much less clear what your program is doing and how it's doing it.

In short, getting data out of a database and turning that into a hash, an ORM
is sometimes a time saver. It should not be used for much more than persisting
your data hashes and retrieving data and converting that data into hashes.

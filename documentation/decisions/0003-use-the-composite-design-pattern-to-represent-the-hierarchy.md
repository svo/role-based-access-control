# 3. Use the composite design pattern to represent the hierarchy

Date: 2021-03-20

## Status

Accepted

## Context

### Ideal

We have an accepted approach for storing and retrieving a role hierarchy.

### Reality

We currently don't have a decided on approach.

### Consequences

* we cannot design the solution without making a decision on the implementation path

### Options

#### Option 1: Composite Design Pattern

Pros:

* ubiquitous pattern for representing a hierarchy
* translates well to database usage in the future

Cons:

* requires items to be added in order i.e. parents added before their children
* performance issues with deep hierarchies
* can be costly on reads due to recursive nature (especially if represented in a database)

#### Option 2: Materialised Path

Pros:

* high performance reads
* translates well to database usage in the future

Cons:

* requires items to be added in order i.e. parents added before their children; or path updates if supporting out of order additions
* can be costly to do updates if supporting out of order additions

#### Option 3: Use a Tree Data Structure

Pros:

* can use a library

Cons:

* strictly in memory

#### Option 4: Use a List Data Structure

Pros:

* simple to comprehend

Cons:

* requires processing the entire list for any read

## Decision

We will use the Composite Design Pattern for implementing the hierarchy.

## Consequences

* performance implications with deeper tree structure
* favouring write performance over read
* can deliver rapidly

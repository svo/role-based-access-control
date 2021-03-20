# Role Based Access Control

## Problem Statement

### Ideal

Ideally we can control the degree of the behaviour available in our software based on the type of user that is accessing it and where that type lies in a hierarchy.

### Reality

In reality our software currently has no user type/hierarchy so we are unable to restrict/allow behaviours in the desired fashion.

### Consequences

* people can perform actions that ideally they shouldn't perform
* people can see information that ideally they shouldn't be able to

### Proposal

Implement a user hierarchy mechanism that allows for cascading of permissions.

## Build

How you can contribute to the projects development and build locally on a `*nix` environment.

## Test

How you can run the tests on a `*nix` environment to assert the solution behaviours are as expected.

## Run

How to run the solution locally.

## Design Decisions

[Decision Register](documentation/decisions)

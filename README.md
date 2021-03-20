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

How you can contribute to the project development and build locally on a `*nix` environment.

This project uses infrastructure as code mechanisms to provide a developer experience. The experience is delivered using [Vagrant](https://www.vagrantup.com), [VirtualBox](https://www.virtualbox.org) and [Ansible](https://github.com/ansible/ansible).

To start and build a `VirtualBox` Virtual Machine for developing on the project, run the following command from the terminal in the current directory.

```
vagrant up
```

You may of course decide to just use the ansible configuration as a reference and configure your local machine to reflect the system requirements.

This project is using [Ruby](https://www.ruby-lang.org/en/) as the primary programming language, with the decision being documented [here](documentation/decisions/0002-use-ruby-as-the-programming-language-for-the-project-behaviours.md) and the configured version being `3.0.0`.

### Tested Configurations

| Requirement | Version |
|--|--|
| OS | macOS Catalina 10.15.7  |
| Vagrant | 2.2.14 |
| VirtualBox | 6.1.18 r142142 (Qt5.6.3) |
| Ansible | 2.10.6 |

## Test

How you can run the tests on a `*nix` environment to assert the solution behaviours are as expected.

## Run

How to run the solution locally on a `*nix` environment.

## Decisions

We are using [adr-tools](https://github.com/npryce/adr-tools) to capture project decisions.

[Decision Register](documentation/decisions)

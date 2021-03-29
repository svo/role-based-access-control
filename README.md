# Role Based Access Control

[![Actions Status](https://github.com/svo/role-based-access-control/actions/workflows/main.yml/badge.svg)](https://github.com/svo/role-based-access-control/actions/)

## Note

This is a naive project being used to demonstrate patterns and practices and is in no way to be considered production appropriate/complete.

## Links

* [Task Board](https://trello.com/b/x4NnuJmE/)
  * the desired experience will require:
    * you to be added to the Team in `Trello`
    * you to allow access to the board for the `Scaled` Power-Up
* [Decision Register](documentation/decisions)
* [Continous Integration](https://github.com/svo/role-based-access-control/actions/)
* [Docker Image - Development with Vagrant](https://hub.docker.com/repository/docker/svanosselaer/role-based-access-control-development)
* [Docker Image - Production](https://hub.docker.com/repository/docker/svanosselaer/role-based-access-control-production)

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

This project uses infrastructure as code mechanisms to provide a developer experience. The experience is delivered using [Vagrant](https://www.vagrantup.com), ([VirtualBox](https://www.virtualbox.org) and/or [Docker](https://www.docker.com)) and [Ansible](https://github.com/ansible/ansible).

To start a `Docker` container for developing on the project, run the following command from the terminal in the current directory:

```
vagrant up docker
```

To start and build a `VirtualBox` Virtual Machine for developing on the project, run the following command from the terminal in the current directory:

```
vagrant up virtualbox
```

To have both, run the following command from the terminal in the current directory:

```
vagrant up
```

You may decide to just use the `Ansible` configuration as a reference and configure your local machine to reflect the system requirements.

This project is using [Ruby](https://www.ruby-lang.org/en/) as the primary programming language, with the decision being documented [here](documentation/decisions/0002-use-ruby-as-the-programming-language-for-the-project-behaviours.md) and the configured version being `3.0.0`.

### Tested Configurations

| Requirement | Version |
|--|--|
| Operating System | macOS Catalina 10.15.7  |
| Vagrant | 2.2.14 |
| VirtualBox | 6.1.18 r142142 (Qt5.6.3) |
| Ansible | 2.10.6 |
| Docker | 20.10.5, build 55c4c88 |

### Building Development Docker Image

To build a new version of the development `Docker` image, run the following command from the terminal in the current directory:

```
vagrant up virtualbox
vagrant ssh
cd /vagrant
bin/build-development-image
```

**Note:** to run on another environment you will also need to install [Packer](https://www.packer.io).

## Setup

How you can setup the project dependencies on a `*nix` environment.

If using the `Vagrant` setup run the following:

```
vagrant up docker
vagrant ssh
cd /vagrant
```

To install the dependencies, run the following command:

```
bin/setup
```

## Test

How you can run the tests on a `*nix` environment to assert the solution behaviours are as expected.

If using the `Vagrant` setup run the following:

```
vagrant up docker
vagrant ssh
cd /vagrant
```

You can then run the tests using:

```
bundle exec rake
```

If on the `VirtualBox` or `Docker` setup you can use the following:

```
bin/test
```

**Note:** to run on another environment you will also need to install [Semgrep](https://semgrep.dev).

## Run

How to run the solution locally on a `*nix` environment.

If using the `Vagrant` setup run the following:

```
vagrant up docker
vagrant ssh
cd /vagrant
```

To run the web application use the following command:

```
bin/run
```

You can also use the production docker image for the project by running the following:

```
docker run -d -p 4567:4567 --name=role-based-access-control svanosselaer/role-based-access-control-production:latest
```

You can now use the API to make the calls required e.g.:

```
curl -X POST -d @role.json http://localhost:4567/role
curl -X POST -d @user.json http://localhost:4567/user
curl http://localhost:4567/user
curl http://localhost:4567/role
curl http://localhost:4567/user/3/subordinate
curl http://localhost:4567/user/1/subordinate
```

The examples above can be ran by using the following command:

```
bin/test-examples
```

## Decisions

We are using [adr-tools](https://github.com/npryce/adr-tools) to capture project decisions.

[Decision Register](documentation/decisions)

## Design

### Class Diagram

![Class Diagram](https://raw.githubusercontent.com/svo/role-based-access-control/main/documentation/architecture/class.png)

## System Of Work

### 1. Know What We Are Doing

![Know What We Are Doing](https://raw.githubusercontent.com/svo/role-based-access-control/main/documentation/process-so-we-know-what-we-are-doing.png)

### 2. So We Can Implement

![So We Can Implement](https://raw.githubusercontent.com/svo/role-based-access-control/main/documentation/process-so-we-can-start-implementation.png)

### 3. Plan

![Planning](https://raw.githubusercontent.com/svo/role-based-access-control/main/documentation/process-plan-tasks.png)

### 4. Implement

![Execution](https://raw.githubusercontent.com/svo/role-based-access-control/main/documentation/process-do-task.png)

# sergidesembre/makefile-php

The purpose of this project is a small training about how function makefile, good practices and standards.

## Table of Contents

- [Requirements](#requirements)
- [How to use](#how-to-use)

## Requirements
```text
docker-compose version 1.29
Composer version 2.2
```

## How to use
Easy! Only needs to copy ```Makefile``` file and ```.makefile``` folder with all content so you can start to use.

The principal file have all targets organized by namespaces. Each target set value of variables and that execute make into specific .mk file from ```.makefile``` folder.

When execute targets of ```quality``` or ```tests``` namespaces never must execute directly command, it's a good option to define script command in ```composer.json``` file with custom options, this way all coworkers can use command with options, it's more encapsulated and cohesive.
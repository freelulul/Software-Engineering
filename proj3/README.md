# CS132: Software Engineering

This template should help get you started developing the final project of Software Engineering with MATLAB. You are required to follow the conventions set by this template so that the teaching staff can run your code properly and find the documents easily.

## Recommended IDE Setup

- [MATLAB 2021b](https://software.shanghaitech.edu.cn/)
- (Optional) [VS Code](https://code.visualstudio.com/) + [Matlab](https://marketplace.visualstudio.com/items?itemName=Gimly81.matlab) + [matlab-formatter](https://marketplace.visualstudio.com/items?itemName=AffenWiesel.matlab-formatter) + [Octave Debugger](https://marketplace.visualstudio.com/items?itemName=paulosilva.vsc-octave-debugger) (and install GNU Octave)

**Note that you should use and only use MATLAB 2021b in your project. Other version of MATLAB is not accepted.**

## File Structure

This template is structured as below: 

```bash
template
|  .editorconfig
│  .gitignore
│  env.m
│  index.m
│  README.md
├─.vscode
├─assets
├─docs
│  ├─manual
│  ├─report
│  ├─requirement
│  ├─specification
│  └─validation
├─src
│      main.m
└─tests
    ├─unittest
    └─uppaal
```

- `env.m`: This file is where your project initializations takes place. These initializations may include: environment setup, database connection, etc. It is guaranteed to executed before the execution of your application and testing.
- `index.m`: This file is the entrypoint for the teaching staff to run your project. You should also run your application from it in development stage. When teaching staff is running your project, It is guaranteed that the `env.m` will be executed before the execution of your application. However, the rest  may differ from what you anticipated, so your code should have zero dependency to this file.
- **assets**: This directory is where you keep your static files.
- **docs**: This directory is where you keep all your documents.
  - **manual**: This directory is where you keep your manual. A [manual](./docs/manual/Manual.pdf) from last year is given as a reference.
  - **report**: This directory is where you keep your weekly meeting reports and summaries before each consultation. An [example](./docs/report/Team_0_Week_0_Report.md) is given as a reference.
  - **requirement**: This directory is where you keep your requirement related documents. A [requirement document](./docs/requirement/Requirement.pdf) and a [traceability document](./docs/requirement/Traceability.pdf) from last year is given as a reference.
  - **specification**: This directory is where you keep your development specification documents. A [specification document](./docs/specification/Specifications.pdf) from last year is given as a reference.
  - **validation**: This directory is where you keep your validation documents. A [validation document](./docs/validation/Validation.pdf) from last year is given as a reference.
- **src**: This directory is where you keep your source code.
  - `main.m`: This is the real entrypoint of your application. Except from the environment setup in `env.m`, your application should start from here. A toy project is given for you as reference.
- **tests**: This directory is where you keep your testing files.
  - **unittest**: This directory is where you keep your unit test code. A toy test is given for you as reference. Apart from this folder, you are free to add other folders to conduct other forms of testing.
  - **uppaal**: This directory is where you keep your model checking files. An UPPAAL file from last year is given as reference.

## Project Description

In CS132: Software Engineering, each team is required to finish 3 projects, with each teammate playing different roles in different projects.

- **Elevator**
  - A building with 3 floors
  - 2 elevators (should be coordinated)
  - Interfaces
    - Button panels and display inside each elevator
    - Button panels and display on each floor
  - Sensors
    - Door open, door closed
    - Elevator arrive at each floor
  - Controller actions
    -  Open door, close door, move up, move down, stop
- **Huarong Path**
  - Interface
    -  Visualize current state
  - Initial state
    - Standard
    - Random (Use UPPAAL to find solution)
- **12306**
  - Design a system for booking train tickets
  - System Backend
    - A bidirectional railway route with k stations 
    - n trains every day 
      - Departure and destination can be a subsection of the route 
      - Fixed schedule (always on time) 
      - Each train has m seats 
    - Display the state of each train 
      - Location, seat occupation 
    - State of the passenger (checked in/at gate/on the train
  - APP 
    - Show available train tickets for given departure, destination, departure  time and date 
    - Book, cancel, reschedule tickets 
    - Multiple APPs should be able to run simultaneously 
    - Rules are similar to the real 12306

Each role is specified below: 

- **Requirement**
  - UML diagrams
    - Collaborate with development guy/gal
  - Model of system environment for validation 
    - Collaborate with validation guy/gal
  - Traceability report 
    - Collaborate with both development and validation 
    - Focus on requirement
  - User Manual
- **Development**
  - Detailed UML diagrams reflecting actual design 
    - Collaborate with requirement guy/gal
  - Implementation of the design
  - Traceability report
    - Collaborate with both requirement and validation
    -  Focus on specification, model translation and code
- **Validation**
  - Validation planning and execution
  - Risk Management 
  - Testing 
  - Model checking  
  - Traceability 
    - Collaborate with other two guys/gals 
    - Focus on test case, models in model checking

## Weekly Routine

Every week your team should hold a development meeting and upload the weekly report. Before every consultation, your team should upload a summary covering the progress of your project in the past period.



## MATLAB Tricks

MATLAB is handy for scientific computing, but can be hard for developing a large software. Here are some MATLAB tricks that may useful for your development.

- The Language
  - MATLAB is a scripting language. Unlike Python, MATLAB is interpreted line by line, which means that you can change your code and set breakpoints even in the middle of debugging.
  - MATLAB is single-threaded, which means that any blocking will stop the execution of the whole program. You are recommend to save callbacks and execute them in an asynchronized manner.
  - MATLAB is a dynamic and dynamic, weak-typed language. This means many bugs in your code can only be found at runtime. It is advised to use `isa(var, typename)` or `class(var)` to make type assertions in your code. 
- Functions and Classes
  - MATLAB allows you to define multiple functions and classes in one file, but only the one with the same name as the file will be exported.
  - MATLAB defines its return value in the declaration of the function. You can define multiple return values by wrapping them with `[].`
  - Default MATLAB objects are passed by value. When defining a Class, inherit from `handle` will make its instances passed by reference.
  - `struct` in MATLAB can be helpful for data-only classes.
- Closures and Lambdas
  - Function inside a function is allowed in MATLAB, and the environment is captured automatically. Here we call this kind of function a closure.
  - Default lambdas `@()...` in MATLAB only contains one line of code. However, you can write more complicated code in a closure and execute it inside a lambda.


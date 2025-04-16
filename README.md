> ⚠️ **Note:** This configuration is still a work in progress

## Prerequisites

### Required Tools
The following tools must be available in your PATH:

-- **unzip** - Necessary for Mason
- **make** - Build automation tool
- **fzf** - Command-line fuzzy finder
- **gcc** - GNU Compiler
- **Node.js** - JavaScript runtime environment

### Installation Guide

#### Using [Scoop](https://scoop.sh/) (Windows):
```
scoop install unzip make gcc fzf
```

For Node.js, install directly from the [official website](https://nodejs.org/en).

## Java Requirements

### Language Server Configuration
This project uses JDTLS (Java Language Server) which requires:
- **Java 21+** to run the language server itself

You can configure different Java runtimes for your projects while maintaining Java 21+ for the language server.

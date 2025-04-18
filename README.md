> ⚠️ **Note:** This configuration is still a work in progress

## Prerequisites

### Required Tools
The following tools must be available in your PATH:

- **unzip** - Necessary for Mason
- **make** - Build automation tool
- **fd** - alternative to "find"
- **fzf** - Command-line fuzzy finder
- **ripgrep** - Directory regex matcher
- **gcc** - GNU Compiler
- **Node.js** - JavaScript runtime environment

### Installation Guide

#### Using [Scoop](https://scoop.sh/) (Windows):
```
scoop install unzip make fd fzf ripgrep gcc
```

For Node.js, install directly from the [official website](https://nodejs.org/en).

## Java Requirements

### Language Server Configuration
This project uses JDTLS (Java Language Server) which requires:
- **Java 21+** to run the language server itself

You can configure different Java runtimes for your projects while maintaining Java 21+ for the language server.

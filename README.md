> ⚠️ **Note:** This configuration is still a work in progress

## Prerequisites

### Required Tools
The following tools must be available in your PATH:

- **git**
- **java**
- **unzip**
- **make**
- **fd**
- **rg**
- **fzf**
- **bat**
- **gcc**
- **node**
- **lazygit**
- **lazydocker**

## Java Requirements

### Language Server Configuration
This project uses JDTLS (Java Language Server) which requires:
- **Java 21+** to run the language server itself


### Testing
Testing is also done by JDTLS but it requires you to set up the bundles for it.

Specifically **vscode-java-test 0.43.1**:
  - I'd recommend manually cloning the [**vscode-java-test**](https://github.com/microsoft/vscode-java-test) repo and building the bundles yourself. Follow this [simple guide](https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#vscode-java-test-installation).
  - Since the 0.43.1 release fixed a lot of issues I've had with testing in jdtls.

You can configure different Java runtimes for your projects while maintaining Java 21+ for the language server itself.

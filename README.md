# Nix Flake Templates

## Overview

This repository provides a collection of Nix flake templates to help you quickly
bootstrap new projects with the necessary configurations and tools. Each
template is designed to be easily customizable and comes with pre-configured
settings to streamline your development workflow.

## Features

- **Generic Template**: A versatile template with pre-commit hook integration,
  GitHub Actions workflows, and basic project structure.
- **Pre-commit Hooks**: Integrated pre-commit hooks to ensure code quality and
  consistency.
- **GitHub Actions**: Automated workflows for checking flakes, updating lock
  files, and publishing to FlakeHub.

## Templates

### Generic Template

The generic template is a versatile starting point for any project. It includes:

- **EditorConfig**: Configuration for consistent coding styles across different
  editors.
- **Git Ignore**: Pre-configured `.gitignore` file to exclude unnecessary files.
- **Prettier**: Configuration to ignore `flake.lock` during formatting.
- **Checks**: Pre-commit hooks and flake checks to ensure code quality.
- **Development Shell**: A pre-configured development shell with necessary
  tools.

#### Usage

To use the generic template, run the following command:

```bash
nix flake new -t github:michaelvanstraten/templates
```

## To-do

- [ ] Improve GitHub workflow configurations.
- [ ] Add a template README to each template.
- [ ] Add templates for specific languages and frameworks:
  - [ ] Rust
  - [ ] LaTeX
  - [ ] Python

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to
help improve these templates.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file
for details.

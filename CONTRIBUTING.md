# Contributing to MicrobiomeSOP

Thank you for your interest in contributing to MicrobiomeSOP! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue on GitHub with:
- A clear, descriptive title
- Steps to reproduce the problem
- Expected behavior vs. actual behavior
- Your environment (R version, OS, package versions)
- Any relevant error messages or logs

### Suggesting Enhancements

We welcome suggestions for new features or improvements! Please:
- Check if the feature has already been requested
- Open an issue describing the enhancement
- Explain why this feature would be useful
- Provide examples of how it would work

### Pull Requests

1. **Fork the repository** and create a new branch from `main`
2. **Make your changes** following the code style guidelines
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Submit a pull request** with a clear description of the changes

## Development Setup

1. Clone your fork:
```bash
git clone https://github.com/YOUR-USERNAME/MicrobiomeSOP.git
cd MicrobiomeSOP
```

2. Set up the R environment:
```bash
Rscript scripts/setup_renv.R
```

3. Create a new branch:
```bash
git checkout -b feature/your-feature-name
```

## Code Style Guidelines

### R Code
- Use informative variable and function names
- Follow tidyverse style guide
- Add comments for complex logic
- Use `<-` for assignment (not `=`)
- Maximum line length: 80 characters

### Rmarkdown
- Use clear section headers
- Include chunk options for reproducibility
- Add descriptive chunk names
- Comment complex code blocks

### Configuration
- Document all new config parameters
- Provide sensible defaults
- Include parameter descriptions

## Testing

Before submitting a pull request:

1. **Test with example data**: Ensure the pipeline runs without errors
2. **Check documentation**: Verify all changes are documented
3. **Validate outputs**: Confirm expected results are produced
4. **Test edge cases**: Consider unusual inputs or parameters

## Documentation

- Update README.md for major features
- Add inline comments for complex code
- Update CHANGELOG.md with your changes
- Update QUICKSTART.md if user workflow changes

## Commit Messages

Use clear, descriptive commit messages:
- Use present tense ("Add feature" not "Added feature")
- First line: brief summary (50 chars or less)
- Add detailed description if needed
- Reference issues/PRs when relevant

Example:
```
Add support for single-end sequencing

- Modify DADA2 workflow to handle single-end reads
- Update config.yaml with single-end parameters
- Add documentation for single-end analysis

Fixes #123
```

## Areas for Contribution

We especially welcome contributions in these areas:

### High Priority
- Additional statistical tests (DESeq2, LEfSe, etc.)
- Support for single-end sequencing
- Additional visualization options
- Performance optimization
- Error handling improvements

### Documentation
- Tutorial videos or guides
- Example datasets
- FAQ section
- Troubleshooting guide

### Features
- Support for additional taxonomy databases
- Integration with other analysis tools
- Batch processing utilities
- Quality control metrics

## Code Review Process

1. Maintainers will review your PR
2. Feedback will be provided via comments
3. Make requested changes if needed
4. Once approved, your PR will be merged

## Questions?

If you have questions about contributing:
- Open an issue on GitHub
- Check existing issues and documentation
- Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (see LICENSE file).

## Recognition

Contributors will be acknowledged in:
- The project README
- Release notes
- CHANGELOG

Thank you for helping improve MicrobiomeSOP!

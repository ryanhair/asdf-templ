<div align="center">

# asdf-templ [![Build](https://github.com/ryanhair/asdf-templ/actions/workflows/build.yml/badge.svg)](https://github.com/ryanhair/asdf-templ/actions/workflows/build.yml) [![Lint](https://github.com/ryanhair/asdf-templ/actions/workflows/lint.yml/badge.svg)](https://github.com/ryanhair/asdf-templ/actions/workflows/lint.yml)

[templ](https://github.com/ryanhair/asdf-templ) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add templ
# or
asdf plugin add templ https://github.com/ryanhair/asdf-templ.git
```

templ:

```shell
# Show all installable versions
asdf list-all templ

# Install specific version
asdf install templ latest

# Set a version globally (on your ~/.tool-versions file)
asdf global templ latest

# Now templ commands are available
templ --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ryanhair/asdf-templ/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ryan Hair](https://github.com/ryanhair/)

## Setup instructions for MacOS

### [Iterm2](https://iterm2.com/)

### [VS Code](https://code.visualstudio.com/docs/setup/mac)

### [Homebrew](https://brew.sh/)

Install homebrew 

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
``` 

and add it to the `PATH`

```shell
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/atb033/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### [Fuzzy Finder](https://formulae.brew.sh/formula/fzf#default)

Install fzf

```shell
brew install fzf
```

and add keybindings and fuzzy completions

```
/opt/homebrew/opt/fzf/install
```

### [Oh my zsh](https://ohmyz.sh/#install)

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### [pip](https://pip.pypa.io/en/stable/)

Upgrade pip as the default version shows some error. See [this](https://exerror.com/importerror-cannot-import-name-packagefinder/)

```shell
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```
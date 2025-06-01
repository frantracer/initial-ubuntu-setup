# Download and run setup

curl -sSL https://raw.githubusercontent.com/frantracer/initial-ubuntu-setup/refs/heads/main/setup.sh | bash

# Setup git with GPG key

```
gpg --full-generate-key
export KEY=$(gpg --list-secret-keys --keyid-format=long | grep sec | awk '{print $2}' | sed 's/.*\///')
gpg --armor --export $KEY
# Copy the output and add it to your GitHub account at: https://github.com/settings/gpg/new
```

```
git config --global user.signingkey $KEY
git config --global commit.gpgsign true
git config --global tag.gpgSign true
git config --global user.name "name"
git config --global user.email "your@email.com"
```

# Setup Gnome extensions

Install through Extension Manager:
- Dash to Panel
- Caffeine
- Clipboard Indicator

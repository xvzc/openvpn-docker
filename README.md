# openvpn-docker

# Installation
```bash
curl -L https://github.com/xvzc/openvpn-docker/archive/refs/tags/0.6.tar.gz > \
  openvpn.tar.gz && tar -xvzf ./openvpn.tar.gz \
  --strip-components 1 && rm ./openvpn.tar.gz; \
  bash ./install.sh
```

# Run
`./run`

# Open config
`./config`

# Create user
`./add-user name`
> ovpn file will be stored in $HOME/users

# Delete user
`./delete-user name`
> this will remove the ovpn file stored in $HOME/users

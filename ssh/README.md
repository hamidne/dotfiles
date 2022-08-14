# SSH

> a good document is [github ssh reference](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

## Generate SSH key for each account

``` bash
cd ~/.ssh # change working directory

# generate key-pairs
ssh-keygen -t ed25519 -C "mohammadne.dev@gmail.com"
ssh-keygen -t ed25519 -C "mohammad.nasresfahani@snapp.cab"
```

> the key-generator prompts for a file name, enter the `id_ed25519` and `id_ed25519_snapp` respectively.

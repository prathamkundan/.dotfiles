My dotfiles with a simple dotfiles management script.

Mappings are defined in `config.sh`. They map the dotfiles in this project with
where they should be. 

When running on a new system run:

```sh
./dotty.sh -s -b ~/.dofiles_backup '*'
```

for new mappings use the map_env method:

```sh
map_env \
    "<group name>" "<from: path local to .dotfiles>" "<to: where dotfile/dir should be>"
```

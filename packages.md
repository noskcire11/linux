### Install keyd

```bash
[erickson@arch ~]$ git clone https://github.com/rvaiya/keyd
[erickson@arch ~]$ cd keyd
[erickson@arch ~]$ make && sudo make install

/etc/keyd/default.conf
-------------------------------------------------------------
[ids]

*

[main]

# Maps capslock to escape when pressed and control when held.
capslock = overload(control, esc)

# Remaps the escape key to capslock
#esc = capslock

[erickson@arch ~]$ sudo systemctl enable --now keyd
```

### Install `fnm` (node version manager)

```bash
[erickson@arch ~]$ curl -fsSL https://fnm.vercel.app/install | bash

~/.bashrc
---------------------------------------------------
# fnm
export PATH="/home/erickson/.local/share/fnm:$PATH"
source <(fnm completions --shell bash)
eval "$(fnm env --use-on-cd)"

[erickson@arch ~]$ fnm list-remote
[erickson@arch ~]$ fnm install <version>
[erickson@arch ~]$ fnm use <version>
[erickson@arch ~]$ fnm list
[erickson@arch ~]$ fnm current
```

### Install `pyenv` (python version manager)

```bash
[erickson@arch ~]$ curl https://pyenv.run | bash

~/.bashrc
---------------------------------------------------
# fnm
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

[erickson@arch ~]$ pyenv install -l
[erickson@arch ~]$ pyenv install <version>
[erickson@arch ~]$ pyenv global <version>
```

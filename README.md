# Tmux Sessions picker

## Install
```
use 'tricarbonate/tmux-sessions-picker'
```

## Hotkeys
<CR> - Switch to selected tmux session


## Configuration
This Telescope extensions must be loaded with Telescope
```
require'telescope'.setup {
    extensions = {
        sessions_picker = {
        }
    }
}
require('telescope').load_extension('sessions_picker')
```


## Available commands
```
:Telescope sessions_picker

"Using lua function
lua require('telescope').extensions.sessions_picker.sessions_picker()
```

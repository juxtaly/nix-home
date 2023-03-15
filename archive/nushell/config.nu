alias hm = home-manager
alias lg = lazygit
alias cat = bat
alias nvim-packer-compile = nvim --headless -c 'autocmd User PackerCompileDone quitall' -c 'PackerCompile'
alias nvim-packer-sync = nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# List valid lib directories in $env.NU_LIB_DIRS
def list-valid-lib-dirs [] {
    $env.NU_LIB_DIRS | where {|p| $p | path exists}
}

# List libs under directories in $env.NU_LIB_DIRS
def list-libs [] {
    (list-valid-lib-dirs
        | each {|d| [[parent libs]; [$d (ls $"($d)/**/*.nu" | get name)]]}
        | flatten
        | each {|i| $i.libs | reduce {|it, acc| $acc | append [[parent lib]; [$i.parent $it]]}}
        | flatten
        | each {|i| $i.lib | path relative-to $i.parent})
}

# Find lib file under $env.NU_LIB_DIRS
def find-lib [
    name: string # Relative path to the directories in $env.NU_LIB_DIRS
] {
    (list-valid-lib-dirs
        | each {|d| ls $"($d)/**/($name)"}
        | flatten
        | where type == file and (name | str ends-with '.nu')
        | get name)
}

# List custom commands
def list-custom-commands [] {
    help commands | where command_type == custom
}

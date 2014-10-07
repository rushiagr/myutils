tenant_id() {
    keystone token-get | grep tenant | awk '{print $4}'
}

alias nlg='nova list | grep'
alias gilg='glance image-list | grep'

alias hsl='heat stack-list'
alias hsc='heat stack-create'
alias hsd='heat stack-delete'
alias hsu='heat stack-update'

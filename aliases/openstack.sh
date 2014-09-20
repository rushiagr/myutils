tenant_id() {
    keystone token-get | grep tenant | awk '{print $4}'
}

alias nlg='nova list | grep'
alias gilg='glance image-list | grep'


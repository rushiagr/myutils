tenant_id() {
    keystone token-get | grep tenant | awk '{print $4}'
}

alias nlg='nova list | grep'
alias gilg='glance image-list | grep'

alias hsl='heat stack-list'
alias hsc='heat stack-create'
alias hsd='heat stack-delete'
alias hsu='heat stack-update'

function osdetails() {
    #TODO do not call 'keystone token-get' thrice
    export uid=$(keystone token-get | grep user_id | awk '{print $4}')
    export tid=$(keystone token-get | grep tenant_id | awk '{print $4}')
    export tok=$(keystone token-get | grep \ id\  | awk '{print $4}')
    echo "Exported: uid tid and tok"
}

alias dsa='. ~/devstack/openrc admin admin'

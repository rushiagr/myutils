alias vssh='vagrant ssh'
alias vss='vagrant ssh'

alias vu='vagrant up'
alias vup='vagrant up'

alias vh='vagrant halt'

alias vsuspend='vagrant suspend'

alias vr='vagrant reload'
alias vreload='vagrant reload'

alias vstatus='vagrant status'
alias vst='vagrant status'

alias vd='vagrant destroy'
alias vdestroy='vagrant destroy'
alias vdf='vagrant destroy -f'

alias vp='vagrant provision'
alias vrvp='vagrant reload && vagrant provision'

function vus() {
    vagrant up $1
    vagrant ssh $1
}

alias vblsa='VBoxManage list vms'
alias vbls='VBoxManage list runningvms'
alias vbstart='VBoxManage startvm'

# Change UUID of vdi device
alias vboxuuid="vboxmanage internalcommands sethduuid"
function vbsave() {
    vboxmanage controlvm $1 savestate
}
function vbstop() {
    vboxmanage controlvm $1 poweroff
}

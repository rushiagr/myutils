# Adjust screen brightness from CLI
br() {
    if [[ -z $1 ]]; then
        echo "usage: br VAL"
        echo "  VAL is between 0.1 to 4.8. Integer values are also allowed"
        return
    fi

    HAS_DOT=$(echo $1 | grep -c "\.") 
    if [ $HAS_DOT -eq 1 ]; then
        BEFORE_DOT=$(echo $1 | cut -d'.' -f1)
        AFTER_DOT=$(echo $1 | cut -d'.' -f2)
        if [ "${AFTER_DOT}" == "" ]; then
            AFTER_DOT=0
        fi
        if [ ! ${#AFTER_DOT} -eq 1 ]; then
            AFTER_DOT=$(echo $AFTER_DOT | sed -r s/.{$((${#AFTER_DOT}-1))}$//)
        fi
        BRIGHT_VAL=$(echo ${BEFORE_DOT}${AFTER_DOT}00)
    else
        BRIGHT_VAL=$(echo ${1}000)
    fi
    echo "Brightness set to $BRIGHT_VAL"
    echo $BRIGHT_VAL | sudo tee /sys/class/backlight/intel_backlight/brightness >/dev/null;
}

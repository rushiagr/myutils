# Adjust screen brightness from CLI
br() {
    if [[ -z $1 ]]; then
        echo "Current brightness is $(cat /sys/class/backlight/intel_backlight/brightness)."
        return
    fi

    # All this circus to allow for decimal numbers as parameters, e.g. 1.2, .3
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
    BRIGHT_VAL=$(echo $BRIGHT_VAL | sed -r s/^0*//)

    echo $BRIGHT_VAL | sudo tee /sys/class/backlight/intel_backlight/brightness >/dev/null;
    echo "Brightness set to $BRIGHT_VAL"
}

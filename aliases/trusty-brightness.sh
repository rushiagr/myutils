# Adjust screen brightness from CLI
br() {
	if [[ -z $1 ]]; then
		echo "usage: br INT"
		echo "  INT is an integer from 1 to 4"
	elif [ $1 -eq 1 -o $1 -eq 2 -o $1 -eq 3 -o $1 -eq 4 ]; then
	        echo $(($1*1000)) | sudo tee /sys/class/backlight/intel_backlight/brightness >/dev/null;
	else
		echo "usage: br INT"
		echo "  INT is an integer from 1 to 4"
	fi
}

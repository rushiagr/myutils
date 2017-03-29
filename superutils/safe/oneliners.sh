function sedeasy {
    if [ $# -ne 3 ]; then
        echo "usage: sedasy CURRENT REPLACEMENT FILENAME"
        return
    fi
    sed -i "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed     -e 's/[\/&]/\\&/g')/g" $3
}

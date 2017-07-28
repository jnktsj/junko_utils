# define subcommand for 'gsutil'
function gsutil() {
    PARAMS=("$@")
    if [[ ${PARAMS[0]} == "mkdir" ]]; then
        if [[ $# -eq 1 ]]; then
            echo "give me directory name(s) you want to make"
            false
        else
            for GSPATH in "${PARAMS[@]:1}"; do
                gsutil ls $GSPATH &> /dev/null
                if [[ $(echo $?) == 0 ]]; then
                    echo "$GSPATH already exists ... skipped."
                else
                    TEMPDIR=`basename $GSPATH`
                    GSDEST=`dirname $GSPATH`
                    mkdir $TEMP/$TEMPDIR
                    touch $TEMP/$TEMPDIR/__empty__
                    gsutil cp -r $TEMP/$TEMPDIR $GSDEST
                    rm -r $TEMP/$TEMPDIR
                fi
            done
            true
        fi
    elif [[ "$@" == "help" ]]; then
        command gsutil "$@"
        echo " "
        echo "Customized subcommand:"
        echo "  mkdir          Make subfolder(s) in a bucket with '__empty__' file"
        true
    else
        command gsutil "$@"
    fi
}

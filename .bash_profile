
##
# source-all: recursively source all files in a path (or the path itself if applicable)
##
shopt -s nullglob
shopt -s dotglob
source-all () {
  # if its a folder source all files in it
  if [ -d "$1" ] ; then
    for filename in "$1"/* ; do
      source-all "$filename"
    done
  # if its a file, source it
  elif [ -f "$1" ] ; then
    if [ "$VERBOSE_REPROFILE" = true ] ; then
      echo "sourcing $1"
    fi
    source "$1"
  fi
}

source-all ~/.bash_colors
source-all ~/.bash_ps1
source-all ~/.bash_env
source-all ~/.bash_aliases
source-all ~/.bash_private


# Add git branch if its present to PS1

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

parse_git_tag () {
  git describe --abbrev=0 --tags 2> /dev/null
}

parse_git_branch_or_tag() {
  local OUT="#$(parse_git_tag) $(parse_git_branch)"
  OUT=`echo "$OUT" | sed -e 's/\s*\(.*\)\s*/\1/'`
  if [ "$OUT" = "# " ]; then
    OUT=`echo "$OUT" | sed -e 's/\s*#\s*//'`
  else
    OUT=" $OUT"
  fi
  echo "$OUT"
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch_or_tag)\[\033[00m\]\$ '

# XML parser

xq () {
        read -d '' var
        while read -r line
        do
                if [ ! -z "$line" ]
                then
                        xmllint --format - <<< $line | pygmentize -l xml
                fi
        done <<< "$var"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aliases

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias py=python

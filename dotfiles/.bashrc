# aliases

alias py='python'
alias k='kubectl'
alias kj='k get jobs'
alias kdj='k describe job'
alias kp='k get pods'
alias kdp='k describe pod'
alias kl='k logs'
alias tf='terraform'
alias laws='aws --endpoint-url=http://localhost:4566' # localstack

# add git branch to PS1

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

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch_or_tag)\[\033[00m\]\n\$ '

# xml parser

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

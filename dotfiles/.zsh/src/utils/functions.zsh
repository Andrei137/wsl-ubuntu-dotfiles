subl() {
    ( /usr/local/bin/subl "$@" & disown ) > /dev/null 2>&1
    return 0
}

sf() {
  local files
  files=($(fd -H "$@" 2>/dev/null))
  [[ ${#files[@]} -eq 0 ]] && return

  if (( ${#files[@]} > 1 )); then
    files=($(printf "%s\n" "${files[@]}" | fzf -m --preview 'bat --style=plain --color always {}'))
  fi
  [[ ${#files[@]} -eq 0 ]] && return

  subl "${files[@]}"
}

xpaste() {
  xclip -selection clipboard -o > "$@"
}

xcut() {
  cat "$@" | xclip -selection clipboard
}

cls() {
  clear
}

cpwd() {
  pwd | xclip -selection clipboard
  echo "Copied to clipboard: $(pwd)"
}

err() {
  zsh -ic "$*"
  echo "Exit code: $?"
}

gpsh() {
  git push origin $(git branch --show-current)
}

gpll() {
  git fetch && git pull origin $(git branch --show-current)
}

gcmm() {
  git commit -m "$@"
}

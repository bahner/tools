#!/bin/bash
set -e

export DELIMITER="::"
export PASSWORD_FILE="${HOME}/Dokumenter/.pw.asc"

print_matching_patterns () {
  gpg --decrypt "${PASSWORD_FILE}" 2> /dev/null \
  | egrep -ie "$@"
}

extract_password () {
  readarray -t matched_line < <(gpg --decrypt "${PASSWORD_FILE}" 2> /dev/null \
    | egrep -ie "$@" \
    | sed "s/${DELIMITER}/\n/g" \
    | sed "s/^[[:space:]]*//g" \
    | sed "s/[[:space:]]*$//g")
  echo "${matched_line[-1]}"
}

put_password_in_clipboard () {
  echo -n "$@" | xclip
}

usage () {
cat <<EOF
Usage: $(basename $0) [-h] [-p ] [-x] [-d "::"] [-f /tmp/pw.file.asc] /password pattern to match/

  -d - set password delimiter in file to string. Default "::"
  -f - password file to use. Default: ~/Dokumenter/.pw.asc
  -h - print this message
  -p - print lines matching pattern too stderr
  -x - don't copy password to clipboard. Default false

  Please note. Using -c requires that only one line matches the password pattern,
  and that the password follows the delimiter pattern. Whitespace is chomped.
EOF

exit $1
}

while getopts "d:f:hpx" opt; do
  case $opt in
    d)
      export DELIMITER="${OPTARG}"
    ;;
    f)
      export PASSWORD_FILE="${OPTARG}"
    ;;
    p)
      export PRINT=true
    ;;
    x)
      export COPY=true
    ;;
    h)
      usage 0
    ;;
    *)
      usage 64
    ;;
  esac
done

# Remove options from the parameter array and conserve only pattern
shift $(( OPTIND -1 ))

# Assign parameter array to sanely name variable for readability
export PATTERN=$@

password=$(extract_password "$PATTERN")

# Prin passwords to 2 
test -n "${PRINT}" && >&2 print_matching_patterns $PATTERN

test -n "${COPY}" || put_password_in_clipboard "$password"

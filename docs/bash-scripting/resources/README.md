# Useful Bash Resources

## Resources

- [Bash Guide][bash-guide]
- [Bash FAQ][bash-faq]
- [Bash Pitfalls][bash-pitfalls]
- [Bash-Hackers Wiki][bash-hacker-wiki]
- [Shellcheck][shellcheck] provides shell script guidelines and help.

[bash-guide]: http://mywiki.wooledge.org/BashGuide
[bash-faq]: http://mywiki.wooledge.org/BashFAQ
[bash-hacker-wiki]: https://wiki.bash-hackers.org/
[bash-pitfalls]: https://mywiki.wooledge.org/BashPitfalls
[shellcheck]: http://www.shellcheck.net/

## Good reads

- [Command Line Interface Guidelines](https://clig.dev/)

## Techniques (tips and tricks)

### Error handling

#### Trap snippets

```bash
### glennj's useful trap
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR

### trap to only report an error, not working within functions if the bad command is not last.
trap 'echo "Error on line $LINENO. Exit code: $?" >&2' ERR

### Trap to exit on error exit code, , not working within functions if the bad command is not last
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### set exit-on-error mode (set -e), trap the exit signal instead of the error
### Useful for cleaning up in case of error
set -Ee
trap 'catch $? $LINENO' EXIT
catch() {
  echo "catching!"
  if [ "$1" != "0" ]; then
    # error handling goes here
    echo "Error $1 occurred on $2"
  fi
}
```

Reads:

[Sending and Trapping Signals](https://mywiki.wooledge.org/SignalTrap)

Bash strict mode(read all of them):

- [Use Bash Strict Mode (Unless You Love Debugging)](http://redsymbol.net/articles/unofficial-bash-strict-mode/)
- [Another Bash Strict Mode](https://disconnected.systems/blog/another-bash-strict-mode/)
- [Bash strict mode and why you should care](https://olivergondza.github.io/2019/10/01/bash-strict-mode.html)
- [The Bash Trap Trap](https://medium.com/@dirk.avery/the-bash-trap-trap-ce6083f36700)
- [Bash Error Handling with Trap](https://citizen428.net/blog/bash-error-handling-with-trap/)

### Handle command-line options (positional parameters)

The day will come when you want to give arguments to your scripts. These arguments are known as positional parameters.

- [BashFAQ/035][BashFAQ/035]
- [Bash Hakers Wiki: Handling positional parameters][bhw-posparams]

[BashFAQ/035]: http://mywiki.wooledge.org/BashFAQ/035
[bhw-posparams]: https://wiki.bash-hackers.org/scripting/posparams

### Global boolean "flags" implemented as functions

```bash
### cut ###
filename_only () { false; }
line_numbers  () { false; }
inverted      () { false; }

### cut ###

    # Process options
    while getopts :ilnxv opt; do
        case $opt in
            l) filename_only () { true; } ;;
            n) line_numbers  () { true; } ;;
            v) inverted      () { true; } ;;
            i) shopt -s nocasematch ;;
            x) pattern_fmt='^%s$' ;;
            ?) echo "Unknown option: $OPTARG" >&2 ;;
        esac
    done
    shift $((OPTIND - 1))

### cut ###
```

Source: [glennj's solution to the grep task](https://exercism.io/tracks/bash/exercises/grep/solutions/1b6e4d45871a4810829d0294ae7112da)

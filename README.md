TOOLS
=====


ip-ranges
---------

This is a simple script to print IP ranges for AWS. Give it a region
as parameter and | sort -u, eg:
    ip-ranges.py eu-west-1 | sort -u > cidrs.eu-west-1


aws-env-update
--------------

Download your AWS API KEY credentials file and run the command
with your account alias (or preferred alias) as parameter.

Script was written to not loose control over API KEYS, and easily
be able to roll them often.

It will extract the credentials, and generate a little bash script
that exports your security tokens.

The nifty part is that the script is GPG encrypted, and coupled
with a shell function, so that you easily can set your API KEYs
with the function awsenv, eg:

    awsenv production

This requires the following function in your bashrc or profile:

```bash
function awsenv () {
 eval "$(cat "${HOME}/.aws/env.${1}.asc" | gpg --decrypt --armor)"
}```


It uses a simple env.conf file in ~/.aws/env.conf which set the following
variables:
```bash
export CREDFILE="${HOME}/Nedlastinger/credentials.csv"
export GPG_RECIPIENT="lars.bahner@gmail.com"
```

You will be asked to delete the credentials file, and you should.

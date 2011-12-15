#!/bin/bash

source tests-common.sh

inherit flag-o-matic

CFLAGS="-a -b -c=1"
CXXFLAGS="-x -y -z=2"
LDFLAGS="-l -m -n=3"

tbegin "is-flag"
! (is-flag 1 2 3) 2>/dev/null
tend $?

tbegin "is-ldflag"
! (is-ldflag 1 2 3) 2>/dev/null
tend $?

while read exp flag ; do
	[[ -z ${exp}${flag} ]] && continue

	tbegin "is-flagq ${flag}"
	is-flagq ${flag}
	[[ ${exp} -eq $? ]]
	tend $? "CFLAGS=${CFLAGS}"
done <<<"
	1	-l
	0	-a
	0	-x
"

while read exp flag ; do
	[[ -z ${exp}${flag} ]] && continue

	tbegin "is-ldflagq ${flag}"
	is-ldflagq "${flag}"
	[[ ${exp} -eq $? ]]
	tend $? "LDFLAGS=${LDFLAGS}"
done <<<"
	1	-a
	0	-n=*
	1	-n
"

tbegin "strip-unsupported-flags"
strip-unsupported-flags
[[ ${CFLAGS} == "" ]] && [[ ${CXXFLAGS} == "-z=2" ]]
tend $? "CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}"

texit

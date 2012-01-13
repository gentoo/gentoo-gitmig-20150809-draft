#!/bin/bash

source tests-common.sh

inherit flag-o-matic

CFLAGS="-a -b -c=1"
CXXFLAGS="-x -y -z=2"
LDFLAGS="-l -m -n=3"
ftend() {
	tend $? "CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS} LDFLAGS=${LDFLAGS}"
}

tbegin "is-flag"
! (is-flag 1 2 3) 2>/dev/null
ftend

tbegin "is-ldflag"
! (is-ldflag 1 2 3) 2>/dev/null
ftend

while read exp flag ; do
	[[ -z ${exp}${flag} ]] && continue

	tbegin "is-flagq ${flag}"
	is-flagq ${flag}
	[[ ${exp} -eq $? ]]
	ftend
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
	ftend
done <<<"
	1	-a
	0	-n=*
	1	-n
"

tbegin "strip-unsupported-flags"
strip-unsupported-flags
[[ ${CFLAGS} == "" ]] && [[ ${CXXFLAGS} == "-z=2" ]]
ftend

for v in C CPP CXX F FC LD ; do
	var="${v}FLAGS"
	eval ${var}=\"-filter -filter-glob -${v}\"
done

tbegin "filter-flags basic"
filter-flags -filter
(
for v in C CPP CXX F FC LD ; do
	var="${v}FLAGS"
	val=${!var}
	[[ ${val} == "-filter-glob -${v}" ]] || exit 1
done
)
ftend

tbegin "filter-flags glob"
filter-flags '-filter-*'
(
for v in C CPP CXX F FC LD ; do
	var="${v}FLAGS"
	val=${!var}
	[[ ${val} == "-${v}" ]] || exit 1
done
)
ftend

texit

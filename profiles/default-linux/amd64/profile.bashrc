getPROG() {
    local var=$1
    local prog=$2

    if [[ -n ${!var} ]] ; then
        echo "${!var}"
        return 0
    fi

    local search=
    [[ -n $3 ]] && search=$(type -p "$3-${prog}")
    [[ -z ${search} && -n ${CHOST} ]] && search=$(type -p "${CHOST}-${prog}")
    [[ -n ${search} ]] && prog=${search##*/}

    export ${var}=${prog}
    echo "${!var}"
}

hasme() {
	local x

	local me=$1
	shift
	for x in "$@"; do
		if [ "${x}" == "${me}" ]; then
		return 0
	fi
	done
	return 1
}

test_broken_flags() {
	local mygcc=${1}
	shift
	echo 'main(){}' | ${mygcc} ${@} -E - 2>&1 | egrep "unrecognized .*option" \
		| egrep -o -- '('\''|\"|`)-.*' | sed -r 's/('\''|`|")//g'
}

if [[ ${EBUILD_PHASE} == "setup" ]]; then
	trigger=0
	CFLAGS=" ${CFLAGS} "
	for flag in ${CFLAGS} ; do
		 broken_flag=$(test_broken_flags $(getPROG CC gcc) ${flag})
		 if [[ -n ${broken_flag} ]]; then
		 	ewarn "Filtering out the non-existing CFLAG \"${broken_flag}\""
			CFLAGS=${CFLAGS//" ${broken_flag} "}
		fi
	done
	CXXFLAGS=" ${CXXFLAGS} "
	for flag in ${CXXFLAGS} ; do
		broken_flag=$(test_broken_flags $(getPROG CXX g++) ${flag})
		if [[ -n ${broken_flag} ]]; then
			ewarn "Filtering out the non-existing CXXFLAG \"${broken_flag}\"" 
			CXXFLAGS=${CXXFLAGS//" ${broken_flag} "}
		fi
	done
	for flag in "-fvisibility=hidden" "-fvisibility-hidden" "-fvisibility-inlines-hidden" "-fPIC" "-fpic" "-m32" "-m64" "-g3" "-ggdb3" ; do
		hasme ${flag} ${CFLAGS} ${CXXFLAGS} && trigger=1 && \
		ewarn "Your C(XX)FLAGS contain(s) \"${flag}\" which can break packages."
	done
	if [[ ${trigger} -ge 1 ]]; then
		ewarn ""
		ewarn "Before you file a bug please remove these flags and "
		ewarn "re-compile the package in question as well as all its dependencies"
	fi
unset trigger broken_flag
fi

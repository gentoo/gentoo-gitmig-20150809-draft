# fix for bug 60147, "configure causes sandbox violations when lib64
# is a directory". currently only works with cvs portage.
#SANDBOX_WRITE="${SANDBOX_WRITE}:/usr/lib64/conftest:/usr/lib64/cf"
addwrite /usr/lib64/conftest
addwrite /usr/lib64/cf


# currently theoretical multilib stuff only available if using portage 2.0.51
CHOST32="i686-pc-linux-gnu"
CONF_MULTILIBDIR="${CONF_MULTILIBDIR:=lib32}"
# until everything in the tree understands $(get_libdir), the only sane
# default for this is lib.
CONF_LIBDIR="${CONF_LIBDIR:=lib}"
ARCH_WRAPPER="linux32"
CC32="gcc32"
CPP32="g++32"


setup_multilib_variables() {
	# if run via linux32, uname -m will always return i686
	if [ "$(uname -m)" == "i686" ] ; then
		CONF_LIBDIR="${CONF_MULTILIBDIR:=lib32}"
		CHOST="${CHOST32:=i686-pc-linux-gnu}"

		if [ -x /usr/bin/${CC32:=gcc32} ] ; then
			CC="${CC32:=gcc32}"
			CPP="${CPP32:=g++32}"
		else
			CFLAGS="${CFLAGS} -m32"
			CXXFLAGS="${CXXFLAGS} -m32"
		fi
	else
		# this isnt needed for profiles that set CONF_LIBDIR, but it
		# doesnt hurt to be safe.
		CONF_LIBDIR="${CONF_LIBDIR:=lib64}"
	fi

	export CONF_LIBDIR
}

[ "${CCHOST}" == "" -o "${CCHOST}" == "${CHOST}" -o "${CCHOST}" == "${CHOST32}" ] && setup_multilib_variables

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
[ "${CONF_MULTILIBDIR}" == "lib" -a "${CONF_LIBDIR}" == "lib64" ] && SKIP_MULTILIB_HACK="YES"


# spec switching support only available in gcc 3.4.2-r1 and later
if [ -n "${USE_SPECS}" ] ; then
	GCC_VER="$(${CC:=gcc} -dumpversion)"
	SPECSLOC="/usr/lib/gcc-lib/${CHOST}/${GCC_VER}/"
	if [ -f ${SPECSLOC}/${USE_SPECS}.specs ] ; then
		export GCC_SPECS="${SPECSLOC}/${USE_SPECS}.specs"
	fi
fi


# The version of profile in our 'packages' does not yet set ABI for us nor
# export the CFLAGS_${ABI} envvars... The multilib-pkg patch does, but this
# won't be in portage until atleast .52_pre
if [ -n "${ABI}" ]; then
	export ABI
else
	export ABI="amd64"
fi

export CFLAGS_amd64
export CFLAGS_x86

hack_use_ml() {
	local x
	unset IFS
	for x in ${USE}; do
		if [ "${x}" = "multilib" ]; then
			return 0
		fi
	done
	return 1
}

if ! hack_use_ml; then
	eerror "The 2005.0 profile requires that you have USE=multilib enabled."
	exit 1
fi

# Make sure they updated to 2005.0 properly
if [ -L /lib32 -o -L /usr/lib32 -o -L /usr/X11R6/lib32 ]; then
	eerror "It appears you have switched to the 2005.0 profile without following"
	eerror "the upgrade guide.  Please see the following URL for more information:"
	eerror "http://www.gentoo.org/proj/en/base/amd64/2005.0-upgrade-amd64.xml"
	exit 1
fi

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

if [ -z "${DONTWARNABOUTSYMLINKS}" ]; then
	for dir in /lib /lib64 /usr/lib /usr/lib64 /usr/X11R6/lib /usr/X11R6/lib64 /usr/qt/*/lib /usr/qt/*/lib64 /usr/kde/*/lib /usr/kde/*/lib64; do
		if [ -L "${dir}" ]; then
			ewarn "${dir} is a symlink"
			#exit 1
		fi
	done
	export DONTWARNABOUTSYMLINKS="true"
fi

if [ -z "${IWANTTOTRASHMYSYSTEM}" ]; then
	eerror "The amd64 2005.0 profile is still in active development and"
	eerror "not yet ready for user testing.  An announcement will be made"
	eerror "on gentoo-amd64@gentoo.org once we are ready for testers."
	exit 1
fi

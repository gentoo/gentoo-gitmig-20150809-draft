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
	save_IFS
	unset IFS
	for x in ${USE}; do
		if [ "${x}" = "multilib" ]; then
			restore_IFS
			return 0
		fi
	done
	restore_IFS
	return 1
}

if ! hack_use_ml; then
        eerror "The 2005.0 profile requires that you have USE=multilib enabled."
	exit 1
fi

# The version of profile in our 'packages' does not yet set ABI for us nor
# export the CFLAGS_${ABI} envvars... The multilib-pkg patch does, but this
# won't be in portage until atleast .52_pre

if [ -n "${ABI}" ]; then
	export ABI
elif [ -n "${DEFAULT_ABI}" ]; then
	export ABI="${DEFAULT_ABI}"
else
	export ABI="ppc64"
fi

export CFLAGS_ppc64

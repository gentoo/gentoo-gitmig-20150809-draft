# When merging some packages relevant to python, sandbox cannot access. 
# The following is the workaround of this problem.
# FYI, I have verified that it was unnecessary in the environment where portage-2.0.51.22-r1 and sandbox-1.2.9 were installed.

addpredict /usr/lib64/python2.0/
addpredict /usr/lib64/python2.1/
addpredict /usr/lib64/python2.2/
addpredict /usr/lib64/python2.3/
addpredict /usr/lib64/python2.4/
addpredict /usr/lib64/python2.5/
addpredict /usr/lib64/python3.0/

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

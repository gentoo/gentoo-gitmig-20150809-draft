# lib64 sandbox stuff copied from amd64's profile.bashrc:
# fix for bug 60147, "configure causes sandbox violations when lib64
# is a directory". currently only works with cvs portage.

addwrite /usr/lib64/conftest
addwrite /usr/lib64/cf

# oh goodie, yet ANOTHER sandbox bug!!!! >:|
# without portage 2.0.51 and the following entries, at least dbus will spew
# sandbox violations like mad with python in lib64.
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
	export ABI="sparc32"
fi

export CFLAGS_sparc32
export CFLAGS_sparc64

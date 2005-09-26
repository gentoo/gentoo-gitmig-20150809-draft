# The version of profile in our 'packages' does not yet set ABI for us nor
# export the CFLAGS_${ABI} envvars...

if [[ -n "${ABI}" ]]; then
	export ABI
elif [[ -n "${DEFAULT_ABI}" ]]; then
	export ABI="${DEFAULT_ABI}"
else
	export ABI="amd64"
fi

#export CFLAGS_amd64
export CFLAGS_x86

# Make sure they updated to 2005.0 properly
if [[ (-L /lib32 || -L /usr/lib32 ) && ( ${PORTAGE_CALLER} != "repoman" ) ]] ; then
	eerror "It appears you have switched to the 2005.1 profile without following"
	eerror "the upgrade guide.  Please  upgrade to 2005.0 first. See the following"
	eerror "URL for more information:"
	eerror "http://www.gentoo.org/proj/en/base/amd64/howtos/2005.0-upgrade-amd64.xml"
	exit 1
fi

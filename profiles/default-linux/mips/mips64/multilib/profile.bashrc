# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default-linux/mips/mips64/multilib/profile.bashrc,v 1.1 2005/04/27 05:13:34 kumba Exp $

# This isn't ready for mass consumption by the public.  Until it's ready, 
# block use of this profile.
if [ "${IREALLYWANTTOUSEMIPSMULTILIBANDIKNOWWHATIAMDOING}" != "oompaloompa" ]; then
	echo -e "* Stop trying to use things you don't know how to use :)"
	echo -e "* Wait until they're ready to be used."
	exit 1
fi


# The version of profile in our 'packages' does not yet set ABI for us nor
# export the CFLAGS_${ABI} envvars... The multilib-pkg patch does, but this
# won't be in portage until atleast .52_pre
if [ -n "${ABI}" ]; then
	export ABI
elif [ -n "${DEFAULT_ABI}" ]; then
	export ABI="${DEFAULT_ABI}"
else
	export ABI="o32"
fi

export CFLAGS_o32
export CFLAGS_n32
export CFLAGS_n64

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default-linux/x86/2006.1/server/profile.bashrc,v 1.3 2006/08/31 22:36:47 cardoe Exp $

if [[ ${EBUILD_PHASE} == "setup" ]]
then
	ewarn "This profile has not been tested thoroughly and is not considered to be"
	ewarn "a supported server profile at this time.  For a supported server"
	ewarn "profile, please check the Hardened project (http://hardened.gentoo.org)."
	echo
fi

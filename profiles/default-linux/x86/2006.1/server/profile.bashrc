# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default-linux/x86/2006.1/server/profile.bashrc,v 1.2 2006/07/26 23:03:45 wolf31o2 Exp $

if [[ ${EBUILD_PHASE} == "setup" ]]
then
	ewarn "This profile has not been tested thoroughly and is not considered to be"
	ewarn "a supported server profile at this time.  For a supported server"
	ewarn "profile, please check the Hardened project (http://hadrened.gentoo.org)."
	echo
fi

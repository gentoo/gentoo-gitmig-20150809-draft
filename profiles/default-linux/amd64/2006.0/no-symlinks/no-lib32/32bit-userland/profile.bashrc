# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default-linux/amd64/2006.0/no-symlinks/no-lib32/32bit-userland/profile.bashrc,v 1.1 2006/03/01 18:29:11 blubb Exp $

if [ -z "${IWANTTOTRASHMYSYSTEMHARD}" ]; then
	eerror "The 2006.0/no-symlink/no-lib32/32bit-userland profile is currently broken"
	eerror "and only for development purposes in the tree. An announcement will be sent"
	eerror "out to gentoo-amd64@lists.gentoo.org as soon as it is save for more testing."
fi

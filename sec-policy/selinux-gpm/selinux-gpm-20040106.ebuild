# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gpm/selinux-gpm-20040106.ebuild,v 1.1 2004/01/06 20:24:42 pebenito Exp $

TEFILES="gpm.te"
FCFILES="gpm.fc"

inherit selinux-policy

DESCRIPTION="SELinux policy for the console mouse server"

KEYWORDS="x86 ppc sparc"


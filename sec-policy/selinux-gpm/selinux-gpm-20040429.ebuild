# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gpm/selinux-gpm-20040429.ebuild,v 1.1 2004/04/30 01:55:12 pebenito Exp $

TEFILES="gpm.te"
FCFILES="gpm.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for the console mouse server"

KEYWORDS="x86 ppc sparc"


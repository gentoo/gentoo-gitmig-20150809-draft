# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20040428.ebuild,v 1.1 2004/04/28 16:22:00 pebenito Exp $

TEFILES="named.te"
FCFILES="named.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="x86 ppc sparc"


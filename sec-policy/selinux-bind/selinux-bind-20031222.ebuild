# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20031222.ebuild,v 1.2 2004/01/16 20:05:51 pebenito Exp $

TEFILES="named.te"
FCFILES="named.fc"

inherit selinux-policy

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="x86 ppc sparc"


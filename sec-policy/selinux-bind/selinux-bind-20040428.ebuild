# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20040428.ebuild,v 1.3 2004/09/20 01:55:46 pebenito Exp $

TEFILES="named.te"
FCFILES="named.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="x86 ppc sparc amd64"


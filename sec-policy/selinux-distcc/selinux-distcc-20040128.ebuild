# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-distcc/selinux-distcc-20040128.ebuild,v 1.3 2004/06/28 00:10:37 pebenito Exp $

TEFILES="distcc.te"
FCFILES="distcc.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for distcc"

KEYWORDS="x86 ppc sparc"


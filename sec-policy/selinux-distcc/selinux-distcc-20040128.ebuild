# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-distcc/selinux-distcc-20040128.ebuild,v 1.4 2004/09/20 01:55:47 pebenito Exp $

TEFILES="distcc.te"
FCFILES="distcc.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for distcc"

KEYWORDS="x86 ppc sparc amd64"


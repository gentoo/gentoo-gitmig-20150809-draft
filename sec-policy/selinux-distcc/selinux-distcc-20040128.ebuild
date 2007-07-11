# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-distcc/selinux-distcc-20040128.ebuild,v 1.5 2007/07/11 02:56:48 mr_bones_ Exp $

TEFILES="distcc.te"
FCFILES="distcc.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for distcc"

KEYWORDS="x86 ppc sparc amd64"

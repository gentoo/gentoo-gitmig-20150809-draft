# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gpm/selinux-gpm-20041110.ebuild,v 1.1 2004/11/13 19:51:56 kaiowas Exp $

inherit selinux-policy

TEFILES="gpm.te"
FCFILES="gpm.fc"
IUSE=""

DESCRIPTION="SELinux policy for the console mouse server"

KEYWORDS="x86 ppc sparc amd64"


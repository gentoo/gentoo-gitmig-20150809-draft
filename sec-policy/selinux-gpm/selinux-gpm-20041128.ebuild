# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gpm/selinux-gpm-20041128.ebuild,v 1.2 2005/05/23 17:02:35 spb Exp $

inherit selinux-policy

TEFILES="gpm.te"
FCFILES="gpm.fc"
IUSE=""

DESCRIPTION="SELinux policy for the console mouse server"

KEYWORDS="amd64 ~mips ppc sparc x86"


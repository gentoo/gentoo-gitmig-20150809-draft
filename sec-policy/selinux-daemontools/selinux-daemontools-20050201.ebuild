# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-daemontools/selinux-daemontools-20050201.ebuild,v 1.2 2005/02/06 17:18:30 kaiowas Exp $

inherit selinux-policy

TEFILES="daemontools.te"
FCFILES="daemontools.fc"
MACROS="daemontools_macros.te"
IUSE=""

DESCRIPTION="SELinux policy for daemontools"

KEYWORDS="x86 ppc sparc amd64"


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-arpwatch/selinux-arpwatch-20041120.ebuild,v 1.2 2004/11/23 17:01:00 kaiowas Exp $

inherit selinux-policy

TEFILES="arpwatch.te"
FCFILES="arpwatch.fc"
IUSE=""

DESCRIPTION="SELinux policy for arpwatch"

KEYWORDS="x86 ppc sparc amd64"


# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-arpwatch/selinux-arpwatch-20050219.ebuild,v 1.3 2005/03/23 07:31:04 kaiowas Exp $

inherit selinux-policy

TEFILES="arpwatch.te"
FCFILES="arpwatch.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for arpwatch"

KEYWORDS="x86 ppc sparc amd64"


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-clamav/selinux-clamav-20041112.ebuild,v 1.1 2004/11/13 19:22:55 kaiowas Exp $

inherit selinux-policy

TEFILES="clamav.te"
FCFILES="clamav.fc"
MACROS="clamav_macros.te"
IUSE=""

DESCRIPTION="SELinux policy for Clam AntiVirus"

KEYWORDS="x86 ppc sparc amd64"


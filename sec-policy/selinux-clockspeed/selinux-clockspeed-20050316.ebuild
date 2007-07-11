# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-clockspeed/selinux-clockspeed-20050316.ebuild,v 1.3 2007/07/11 02:56:47 mr_bones_ Exp $

inherit selinux-policy

TEFILES="clockspeed.te"
FCFILES="clockspeed.fc"
IUSE=""

DESCRIPTION="SELinux policy for clockspeed"

KEYWORDS="x86 ppc sparc amd64"

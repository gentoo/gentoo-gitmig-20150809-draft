# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-clockspeed/selinux-clockspeed-20031221.ebuild,v 1.4 2004/06/28 00:25:33 pebenito Exp $

TEFILES="clockspeed.te"
FCFILES="clockspeed.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for clockspeed"

KEYWORDS="x86 ppc sparc"


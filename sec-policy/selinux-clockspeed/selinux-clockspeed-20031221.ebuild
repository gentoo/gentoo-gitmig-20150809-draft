# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-clockspeed/selinux-clockspeed-20031221.ebuild,v 1.5 2004/09/20 01:55:46 pebenito Exp $

TEFILES="clockspeed.te"
FCFILES="clockspeed.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for clockspeed"

KEYWORDS="x86 ppc sparc amd64"


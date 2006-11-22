# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-avahi/selinux-avahi-20061114.ebuild,v 1.1 2006/11/22 05:52:08 pebenito Exp $

IUSE=""

MODS="avahi"

RDEPEND="sec-policy/selinux-dbus"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for avahi"

KEYWORDS="alpha amd64 mips ppc sparc x86"

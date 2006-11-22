# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bluez/selinux-bluez-20061114.ebuild,v 1.1 2006/11/22 05:52:08 pebenito Exp $

IUSE="dbus"

MODS="bluetooth"

inherit selinux-policy-2

RDEPEND="dbus? ( sec-policy/selinux-dbus )"

DESCRIPTION="SELinux policy for bluez bluetooth tools."

KEYWORDS="alpha amd64 mips ppc sparc x86"

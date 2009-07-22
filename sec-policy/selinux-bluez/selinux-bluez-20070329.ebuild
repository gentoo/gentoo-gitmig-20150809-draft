# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bluez/selinux-bluez-20070329.ebuild,v 1.3 2009/07/22 13:12:27 pebenito Exp $

IUSE="dbus"

MODS="bluetooth"

inherit selinux-policy-2

RDEPEND="dbus? ( sec-policy/selinux-dbus )"

DESCRIPTION="SELinux policy for bluez bluetooth tools."

KEYWORDS="amd64 x86"

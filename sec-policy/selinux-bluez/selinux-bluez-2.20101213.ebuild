# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bluez/selinux-bluez-2.20101213.ebuild,v 1.1 2011/02/05 12:07:06 blueness Exp $

IUSE="dbus"

MODS="bluetooth"

inherit selinux-policy-2

RDEPEND="dbus? ( sec-policy/selinux-dbus )"

DESCRIPTION="SELinux policy for bluez bluetooth tools."

KEYWORDS="~amd64 ~x86"

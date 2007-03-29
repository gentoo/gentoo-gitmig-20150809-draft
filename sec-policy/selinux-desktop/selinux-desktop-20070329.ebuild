# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-desktop/selinux-desktop-20070329.ebuild,v 1.1 2007/03/29 23:37:50 pebenito Exp $

IUSE="acpi apm avahi bluetooth crypt dbus hal pcmcia"

MODS="xserver xfs mplayer mozilla java mono wine"

RDEPEND="acpi? ( sec-policy/selinux-acpi )
	apm? ( sec-policy/selinux-acpi )
	avahi? ( sec-policy/selinux-avahi )
	bluetooth? ( sec-policy/selinux-bluez )
	crypt? ( sec-policy/selinux-gnupg )
	dbus? ( sec-policy/selinux-dbus )
	hal? ( sec-policy/selinux-hal )
	pcmcia? ( sec-policy/selinux-pcmcia )"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for desktops"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

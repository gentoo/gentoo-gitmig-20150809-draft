# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-avahi/selinux-avahi-20080525.ebuild,v 1.1 2008/05/25 23:49:48 pebenito Exp $

IUSE=""

MODS="avahi"

RDEPEND="sec-policy/selinux-dbus"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for avahi"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"

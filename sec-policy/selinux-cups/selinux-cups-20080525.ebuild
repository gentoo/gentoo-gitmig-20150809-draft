# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-cups/selinux-cups-20080525.ebuild,v 1.2 2009/07/22 13:12:34 pebenito Exp $

MODS="cups"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for cups - the Common Unix Printing System"

DEPEND="sec-policy/selinux-lpd"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86"

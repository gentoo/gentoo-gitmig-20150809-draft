# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-cups/selinux-cups-2.20120215-r1.ebuild,v 1.1 2012/05/20 18:40:08 swift Exp $
EAPI="4"

IUSE=""
MODS="cups"
BASEPOL="2.20120215-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for cups"

KEYWORDS="~amd64 ~x86"

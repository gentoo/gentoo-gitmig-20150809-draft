# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-amavis/selinux-amavis-2.20110726-r1.ebuild,v 1.1 2011/11/15 10:43:53 swift Exp $
EAPI="4"

IUSE=""
MODS="amavis"
BASEPOL="2.20110726-r6"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for amavis"

KEYWORDS="~amd64 ~x86"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mutt/selinux-mutt-2.20110726-r1.ebuild,v 1.1 2011/08/28 21:12:36 swift Exp $
EAPI="4"

IUSE=""
MODS="mutt"
BASEPOL="2.20110726-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mutt"
KEYWORDS="~amd64 ~x86"

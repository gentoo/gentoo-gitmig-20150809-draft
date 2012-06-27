# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mutt/selinux-mutt-2.20120215-r1.ebuild,v 1.1 2012/06/27 20:33:53 swift Exp $
EAPI="4"

IUSE=""
MODS="mutt"
BASEPOL="2.20120215-r13"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mutt"
KEYWORDS="~amd64 ~x86"

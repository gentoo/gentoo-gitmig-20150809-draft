# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-podsleuth/selinux-podsleuth-2.20120215-r14.ebuild,v 1.1 2012/07/17 14:26:59 swift Exp $
EAPI="4"

IUSE=""
MODS="podsleuth"
BASEPOL="2.20120215-r14"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for podsleuth"

KEYWORDS="~amd64 ~x86"

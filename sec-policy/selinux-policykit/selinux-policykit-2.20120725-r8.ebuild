# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-policykit/selinux-policykit-2.20120725-r8.ebuild,v 1.1 2012/12/03 08:52:42 swift Exp $
EAPI="4"

IUSE=""
MODS="policykit"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for policykit"

KEYWORDS="~amd64 ~x86"

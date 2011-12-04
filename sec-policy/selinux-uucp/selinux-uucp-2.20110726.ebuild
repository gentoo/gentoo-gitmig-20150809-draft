# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-uucp/selinux-uucp-2.20110726.ebuild,v 1.1 2011/12/04 19:02:20 swift Exp $
EAPI="4"

IUSE=""
MODS="uucp"
BASEPOL="2.20110726-r7"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for uucp"
KEYWORDS="~amd64 ~x86"

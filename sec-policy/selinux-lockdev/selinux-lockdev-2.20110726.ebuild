# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lockdev/selinux-lockdev-2.20110726.ebuild,v 1.1 2011/08/28 21:13:07 swift Exp $
EAPI="4"

IUSE=""
MODS="lockdev"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for lockdev"

KEYWORDS="~amd64 ~x86"

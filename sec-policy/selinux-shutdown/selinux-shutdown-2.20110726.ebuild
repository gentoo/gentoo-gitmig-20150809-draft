# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-shutdown/selinux-shutdown-2.20110726.ebuild,v 1.1 2011/08/28 21:12:53 swift Exp $
EAPI="4"

IUSE=""
MODS="shutdown"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for shutdown"

KEYWORDS="~amd64 ~x86"

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-logrotate/selinux-logrotate-2.20120725-r5.ebuild,v 1.1 2012/09/22 09:27:25 swift Exp $
EAPI="4"

IUSE=""
MODS="logrotate"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for logrotate"

KEYWORDS="~amd64 ~x86"

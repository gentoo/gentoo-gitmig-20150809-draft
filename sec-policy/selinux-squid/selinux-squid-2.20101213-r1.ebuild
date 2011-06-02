# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-squid/selinux-squid-2.20101213-r1.ebuild,v 1.2 2011/06/02 13:00:00 blueness Exp $

MODS="squid"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for squid"

KEYWORDS="amd64 x86"
DEPEND="sec-policy/selinux-apache"
RDEPEND="${DEPEND}"

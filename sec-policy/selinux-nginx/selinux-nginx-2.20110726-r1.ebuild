# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nginx/selinux-nginx-2.20110726-r1.ebuild,v 1.2 2011/10/23 12:42:31 swift Exp $
EAPI="4"

IUSE=""
MODS="nginx"
BASEPOL="2.20110726-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for nginx"
KEYWORDS="amd64 x86"

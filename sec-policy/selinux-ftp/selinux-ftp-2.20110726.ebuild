# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ftp/selinux-ftp-2.20110726.ebuild,v 1.3 2012/03/31 12:29:07 swift Exp $
EAPI="4"

IUSE=""
MODS="ftp"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ftp"
KEYWORDS="amd64 x86"
BASEPOL="2.20110726-r1"

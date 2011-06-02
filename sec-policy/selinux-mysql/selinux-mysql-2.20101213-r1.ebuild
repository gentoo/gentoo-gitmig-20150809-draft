# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mysql/selinux-mysql-2.20101213-r1.ebuild,v 1.2 2011/06/02 12:39:03 blueness Exp $

MODS="mysql"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mysql"

KEYWORDS="amd64 x86"
POLICY_PATCH="${FILESDIR}/fix-services-mysql-r1.patch"

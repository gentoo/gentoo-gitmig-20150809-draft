# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mysql/selinux-mysql-20040514.ebuild,v 1.2 2004/06/28 00:10:37 pebenito Exp $

TEFILES="mysqld.te"
FCFILES="mysqld.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for mysql"

KEYWORDS="x86 ppc sparc"


# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mysql/selinux-mysql-20040514.ebuild,v 1.1 2004/05/15 01:31:47 pebenito Exp $

TEFILES="mysqld.te"
FCFILES="mysqld.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for mysql"

KEYWORDS="x86 ppc sparc"


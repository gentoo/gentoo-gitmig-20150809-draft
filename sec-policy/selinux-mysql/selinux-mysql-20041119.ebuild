# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mysql/selinux-mysql-20041119.ebuild,v 1.2 2004/11/23 17:10:16 kaiowas Exp $

inherit selinux-policy

TEFILES="mysqld.te"
FCFILES="mysqld.fc"
IUSE=""

DESCRIPTION="SELinux policy for mysql"

KEYWORDS="x86 ppc sparc amd64"


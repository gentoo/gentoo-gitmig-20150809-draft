# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mysql/selinux-mysql-20041006.ebuild,v 1.1 2004/10/23 09:55:14 kaiowas Exp $

inherit selinux-policy

TEFILES="mysqld.te"
FCFILES="mysqld.fc"
IUSE=""

DESCRIPTION="SELinux policy for mysql"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"


# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mysql/selinux-mysql-20050605.ebuild,v 1.1 2005/06/26 17:14:42 kaiowas Exp $

inherit selinux-policy

TEFILES="mysqld.te"
FCFILES="mysqld.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for mysql"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"


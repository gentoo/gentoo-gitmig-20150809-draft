# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-postgresql/selinux-postgresql-20041120.ebuild,v 1.2 2004/11/23 17:13:16 kaiowas Exp $

inherit selinux-policy

TEFILES="postgresql.te"
FCFILES="postgresql.fc"
IUSE=""

DESCRIPTION="SELinux policy for PostgreSQL"

KEYWORDS="x86 ppc sparc amd64"

RDEPEND=">=sec-policy/selinux-base-policy-20041023"


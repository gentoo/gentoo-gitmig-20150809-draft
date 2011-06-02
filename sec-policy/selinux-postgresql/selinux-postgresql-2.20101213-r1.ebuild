# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-postgresql/selinux-postgresql-2.20101213-r1.ebuild,v 1.2 2011/06/02 12:45:42 blueness Exp $

MODS="postgresql"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for PostgreSQL"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/fix-services-postgresql-r1.patch"

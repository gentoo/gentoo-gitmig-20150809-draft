# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/postgresql-server/postgresql-server-7.4.ebuild,v 1.5 2010/01/11 11:17:17 ulm Exp $

EAPI="1"

DESCRIPTION="Virtual for PostgreSQL libraries"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="${PV}"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="|| ( dev-db/postgresql-server:${SLOT} =dev-db/postgresql-${PV}* )"

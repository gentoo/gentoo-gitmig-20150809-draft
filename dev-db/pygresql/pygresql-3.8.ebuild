# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pygresql/pygresql-3.8.ebuild,v 1.3 2006/04/27 04:17:18 weeve Exp $

inherit eutils distutils

MY_P="PyGreSQL-${PV}"
DESCRIPTION="a Python interface for PostgreSQL database."
SRC_URI="ftp://ftp.pygresql.org/pub/distrib/${MY_P}.tgz"
HOMEPAGE="http://www.pygresql.org/"
LICENSE="as-is"
DEPEND="dev-db/libpq
	dev-lang/python"
KEYWORDS="~sparc ~x86"
IUSE="doc"
SLOT="0"

S="${WORKDIR}/${MY_P}"

DOCS="announce.txt changelog.txt"

src_install() {
	distutils_src_install

	if use doc ; then
		insinto /usr/share/doc/${PF}/tutorial
		doins tutorial/*
	fi
}

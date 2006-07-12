# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypgsql/pypgsql-2.4.ebuild,v 1.7 2006/07/12 16:04:46 agriffis Exp $

inherit distutils

DESCRIPTION="Python Interface to PostgreSQL"
HOMEPAGE="http://pypgsql.sourceforge.net/"
SRC_URI="mirror://sourceforge/pypgsql/pyPgSQL-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ia64 x86"
SLOT="0"
IUSE=""

DEPEND="dev-db/postgresql"

S=${WORKDIR}/${PN}

PYTHON_MODNAME="pyPgSQL"

src_install() {
	distutils_src_install
	dodir /usr/share/doc/${PF}
	cp -R examples ${D}/usr/share/doc/${PF}
	dodoc README
}

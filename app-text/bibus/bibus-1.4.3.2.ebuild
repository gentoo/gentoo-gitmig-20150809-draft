# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibus/bibus-1.4.3.2.ebuild,v 1.1 2009/02/15 17:53:50 patrick Exp $

inherit python multilib eutils

DESCRIPTION="Bibliographic and reference management software, integrates with OO.o and MS Word"
HOMEPAGE="http://bibus-biblio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-biblio/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql sqlite"
# Most of this mess is designed to give the choice of sqlite or mysql
# but prefer sqlite. We also need to default to sqlite if neither is requested.
RDEPEND="virtual/ooo
	=dev-python/wxpython-2.6*
	sqlite? (
		dev-python/pysqlite
		dev-db/sqliteodbc
	)
	!sqlite? (
		mysql? (
			dev-python/mysql-python
			dev-db/myodbc
		)
		!mysql? (
			dev-python/pysqlite
			dev-db/sqliteodbc
		)
	)
	dev-db/unixODBC"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	cp -a bibus-1.4.3 "${P}"
	rm -rf bibus-1.4.3
	cd "${S}"
	epatch "${FILESDIR}"/${P}-install.patch
}

src_install() {
	emake \
		DESTDIR="${D}" \
		oopath="/usr/$(get_libdir)/openoffice/program" \
		prefix='$(DESTDIR)/usr' \
		sysconfdir='$(DESTDIR)/etc' \
		install || die "emake install failed"
	emake \
		DESTDIR="${D}" \
		oopath="/usr/$(get_libdir)/openoffice/program" \
		prefix='$(DESTDIR)/usr' \
		sysconfdir='$(DESTDIR)/etc' \
		install-doc-en || die "emake install failed"
}

pkg_postinst() {
	python_mod_optimize /usr/lib/python2.5/site-packages/bibus
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/python2.5/site-packages/bibus
}

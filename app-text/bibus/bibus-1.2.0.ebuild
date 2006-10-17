# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibus/bibus-1.2.0.ebuild,v 1.1 2006/10/17 06:39:20 dberkholz Exp $

inherit python multilib

DESCRIPTION="Bibliographic and reference management software, integrates with OO.o and MS Word"
HOMEPAGE="http://bibus-biblio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-biblio/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:lib:$(get_libdir):g" \
		-e "s:local/::g" \
		Setup/bibus.sh
}

src_install() {
	emake \
		-f Setup/Makefile \
		DESTDIR="${D}" \
		oopath="/usr/$(get_libdir)/openoffice/program" \
		prefix='$(DESTDIR)/usr' \
		sysconfdir='$(DESTDIR)/etc' \
		install || die "emake install failed"
	emake \
		-f Setup/Makefile \
		DESTDIR="${D}" \
		oopath="/usr/$(get_libdir)/openoffice/program" \
		prefix='$(DESTDIR)/usr' \
		sysconfdir='$(DESTDIR)/etc' \
		install-doc-en || die "emake install failed"

	insinto /usr/share/applications/
	doins Setup/bibus.desktop
	insinto /usr/share/icons/hicolor/48x48/apps/
	doins Pixmaps/bibus.png

	dodoc Docs/installation.txt
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"usr/share/bibus
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"usr/share/bibus
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibus/bibus-1.4.3.ebuild,v 1.1 2008/05/22 14:18:45 markusle Exp $

inherit python multilib eutils

MY_PV="1.4.3"

DESCRIPTION="Bibliographic and reference management software, integrates with OO.o and MS Word"
HOMEPAGE="http://bibus-biblio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-biblio/${PN}_${MY_PV}-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
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

S="${WORKDIR}/${PN}${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-install.patch
	sed -e "s:GENTOO-PF:${P}:g" \
		-e "69aall:\n" \
		-e "s:\$\(compile\)::" \
		-i Makefile || die "Failed to patch makefile"
	sed -e "s:/usr/lib/:/usr/$(get_libdir)/:" \
		-i Setup/bibus.sh Makefile || die "Failed to fix bibus wrapper"
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

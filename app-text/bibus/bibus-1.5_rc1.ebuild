# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibus/bibus-1.5_rc1.ebuild,v 1.1 2009/09/09 02:50:29 markusle Exp $

EAPI="2"

inherit python multilib eutils versionator

MY_PV=${PV/_/}

DESCRIPTION="Bibliographic and reference management software, integrates with OO.o and MS Word"
HOMEPAGE="http://bibus-biblio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-biblio/${PN}-${MY_PV}.tar.gz"
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

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	python_version
	epatch "${FILESDIR}"/${P}-install.patch
	sed -e "s:gentoo-python:python${PYVER}:g" \
		-i Makefile Setup/Makefile Setup/bibus.cfg Setup/bibus.sh \
		|| die "Failed to adjust python paths"
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
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/bibus
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/python${PYVER}/site-packages/bibus
}

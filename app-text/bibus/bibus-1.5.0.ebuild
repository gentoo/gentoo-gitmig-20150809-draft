# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibus/bibus-1.5.0.ebuild,v 1.1 2009/11/12 23:09:05 markusle Exp $

EAPI="2"

inherit python multilib eutils versionator

DESCRIPTION="Bibliographic and reference management software, integrates with OO.o and MS Word"
HOMEPAGE="http://bibus-biblio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-biblio/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql"
# Most of this mess is designed to give the choice of sqlite or mysql
# but prefer sqlite. We also need to default to sqlite if neither is requested.
RDEPEND="virtual/ooo
	=dev-python/wxpython-2.6*
	dev-python/pysqlite
	dev-db/sqliteodbc
	mysql? (
		dev-python/mysql-python
		dev-db/myodbc
	)
	dev-db/unixODBC"
DEPEND="${RDEPEND}"

src_prepare() {
	python_version
	epatch "${FILESDIR}"/${P}-install.patch
	epatch "${FILESDIR}"/${P}-pysqlite.patch
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

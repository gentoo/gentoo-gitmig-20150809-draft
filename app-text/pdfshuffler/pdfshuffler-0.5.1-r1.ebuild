# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdfshuffler/pdfshuffler-0.5.1-r1.ebuild,v 1.1 2012/02/29 23:54:20 marienz Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils fdo-mime gnome2-utils

DESCRIPTION="PDF-Shuffler is GUI app that can merge or split pdfs and rotate, crop and rearrange their pages."
HOMEPAGE="http://sourceforge.net/projects/pdfshuffler/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyPdf
	dev-python/python-poppler"
RDEPEND="${DEPEND}"

DOCS="ChangeLog README TODO AUTHORS"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/pdfshuffler-poppler-0.18.patch"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

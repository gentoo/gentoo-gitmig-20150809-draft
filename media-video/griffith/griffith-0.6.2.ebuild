# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/griffith/griffith-0.6.2.ebuild,v 1.1 2006/09/27 21:21:43 nelchael Exp $

DESCRIPTION="Movie collection manager"
HOMEPAGE="http://griffith.vasconunes.net/"
SRC_URI="http://download.berlios.de/griffith/${P}.tar.gz
	http://download.berlios.de/griffith/${PN}-extra-artwork-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="spell"

DEPEND="dev-python/imaging
	=dev-python/pygtk-2*
	=dev-python/pysqlite-1*
	dev-python/reportlab
	spell? ( dev-python/gnome-python-extras )"

src_compile() {
	# Nothing to compile and default `emake` spews an error message
	true
}

src_install() {

	einfo "Installing Griffith ..."
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README TODO NEWS TRANSLATORS

	einfo "Installing Griffith extra artwork ..."
	cd "${WORKDIR}/${PN}-extra-artwork-${PV}/"
	make DESTDIR="${D}" install

}

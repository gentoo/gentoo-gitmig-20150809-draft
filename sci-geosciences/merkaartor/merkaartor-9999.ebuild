# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/merkaartor/merkaartor-9999.ebuild,v 1.3 2008/09/16 22:23:16 hanno Exp $

inherit qt4 subversion

ESVN_REPO_URI="http://svn.openstreetmap.org/applications/editors/merkaartor/"

DESCRIPTION="A Qt4 based map editor for the openstreetmap.org project"
HOMEPAGE="http://www.irule.be/bvh/c++/merkaartor/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"
DEPEND="x11-libs/qt-webkit
	x11-libs/qt-gui
	media-gfx/exiv2"

S="${WORKDIR}/${PN}"

src_compile() {
	use nls && lrelease Merkaartor.pro || die "lrelease failed"
	eqmake4 Merkaartor.pro PREFIX=/usr GEOIMAGE=1 || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dodoc AUTHORS CHANGELOG HACKING || die "dodoc failed"
}

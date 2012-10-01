# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qxmpp/qxmpp-9999.ebuild,v 1.6 2012/10/01 19:52:08 pinkbyte Exp $

EAPI=4

EGIT_REPO_URI="https://code.google.com/p/qxmpp"

inherit qt4-r2 multilib git-2

DESCRIPTION="A cross-platform C++ XMPP client library based on the Qt framework."
HOMEPAGE="http://code.google.com/p/qxmpp/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	media-libs/speex"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake4 "${S}"/qxmpp.pro "PREFIX=/usr" "LIBDIR=$(get_libdir)"
}

src_install() {
	qt4-r2_src_install
	# Use proper path for documentation
	mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${P} || die "doc mv failed"
}

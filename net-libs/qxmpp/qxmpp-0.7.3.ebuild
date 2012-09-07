# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qxmpp/qxmpp-0.7.3.ebuild,v 1.1 2012/09/07 10:42:58 pinkbyte Exp $

EAPI=4

inherit qt4-r2 multilib

DESCRIPTION="A cross-platform C++ XMPP client library based on the Qt framework."
HOMEPAGE="http://code.google.com/p/qxmpp/"
SRC_URI="http://qxmpp.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	media-libs/speex"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 "${S}"/qxmpp.pro "PREFIX=/usr" "LIBDIR=$(get_libdir)"
}

src_install() {
	qt4-r2_src_install
	# Use proper path for documentation
	mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${P} || die "doc mv failed"
}

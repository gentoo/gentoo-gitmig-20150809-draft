# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.5.0.ebuild,v 1.1 2010/04/04 11:45:56 tommy Exp $

EAPI="2"

inherit base

DESCRIPTION="The glue between Coin3D and Qt"
SRC_URI="http://ftp.coin3d.org/coin/src/all/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

SLOT="0"
LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=media-libs/coin-3.1.2
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( "AUTHORS" "NEWS" "README" "FAQ" "HACKING" "ChangeLog" )

src_configure() {
	econf --with-coin --disable-html-help $(use_enable doc html) htmldir=/usr/share/doc/${PF}/html
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.3.0.ebuild,v 1.3 2006/12/02 21:56:46 beandog Exp $

inherit eutils

DESCRIPTION="SoQt provides the glue between Systems in Motion's Coin high-level 3D visualization library and Trolltech's Qt 2D user interface library."

SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/all/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org/"

SLOT="0"
LICENSE="|| ( GPL-2 PEL )"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="=x11-libs/qt-3*
	>=media-libs/coin-2.4.4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	econf --with-coin --disable-html-help $(use_enable doc html) htmldir=${ROOT}usr/share/doc/${PF}/html
	emake
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README*
}

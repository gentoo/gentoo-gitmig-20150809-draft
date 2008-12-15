# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoQt/SoQt-1.4.1.ebuild,v 1.2 2008/12/15 19:05:07 angelos Exp $

DESCRIPTION="the glue between Coin3D and Qt3"
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
	econf --with-coin --disable-html-help $(use_enable doc html) htmldir=/usr/share/doc/${PF}/html
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README*
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="xiron is a rapid development framework to build multimedia frontends for the xine media playing library"
HOMEPAGE="http://xiron.sourceforge.net/"
LICENSE="GPL-2"

DEPEND=">=media-libs/xine-lib-1_beta8
	lirc? ( app-misc/lirc )
	virtual/x11"

IUSE=" lirc"

SLOT="0"
KEYWORDS="~x86"

SRC_URI="mirror://sourceforge/xiron/${P}.tar.gz"

src_compile() {

	local myconf
	use lirc || myconf="${myconf} --disable-lirc"

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}

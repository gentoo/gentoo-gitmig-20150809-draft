# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squelch/squelch-1.0.1.ebuild,v 1.15 2009/06/06 08:27:26 ssuominen Exp $

EAPI=2
inherit qt3 toolchain-funcs

DESCRIPTION="qt-based Ogg Vorbis player"
HOMEPAGE="http://rikkus.info/squelch.html"
SRC_URI="http://rikkus.info/arch/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="media-libs/libvorbis
	media-libs/libao
	x11-libs/qt:3"
DEPEND="${RDEPEND}"

src_configure() {
	tc-export CXX
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README THANKS
}

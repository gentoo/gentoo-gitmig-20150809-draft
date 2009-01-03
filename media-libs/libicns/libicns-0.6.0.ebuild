# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libicns/libicns-0.6.0.ebuild,v 1.1 2009/01/03 12:50:44 ssuominen Exp $

EAPI=2

DESCRIPTION="A library for the translation of the icns format"
HOMEPAGE="http://sourceforge.net/projects/icns"
SRC_URI="mirror://sourceforge/icns/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	media-libs/jasper"

src_configure() {
	econf --disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog DEVNOTES README TODO
}

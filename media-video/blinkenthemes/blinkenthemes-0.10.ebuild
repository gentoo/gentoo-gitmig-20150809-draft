# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/blinkenthemes/blinkenthemes-0.10.ebuild,v 1.3 2006/05/28 11:36:43 pylon Exp $

DESCRIPTION="Themes for blinkensim"
HOMEPAGE="http://www.blinkenlights.de/"
SRC_URI="http://www.blinkenlights.de/dist/blinkenthemes-0.10.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/blib"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} \
		install || die "install failed"
}

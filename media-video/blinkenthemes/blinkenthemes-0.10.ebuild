# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/blinkenthemes/blinkenthemes-0.10.ebuild,v 1.2 2005/12/18 23:22:45 chainsaw Exp $

DESCRIPTION="Themes for blinkensim"
HOMEPAGE="http://www.blinkenlights.de/"
SRC_URI="http://www.blinkenlights.de/dist/blinkenthemes-0.10.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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

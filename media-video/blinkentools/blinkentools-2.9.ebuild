# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/blinkentools/blinkentools-2.9.ebuild,v 1.1 2005/12/18 00:50:02 pylon Exp $

DESCRIPTION="blinkentools is a set of commandline utilities related to Blinkenlights."
HOMEPAGE="http://www.blinkenlights.de"
SRC_URI="http://www.blinkenlights.de/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/blib
	media-libs/libmng"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} \
		install || die "install failed"
}

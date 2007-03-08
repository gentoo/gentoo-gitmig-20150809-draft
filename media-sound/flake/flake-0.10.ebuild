# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flake/flake-0.10.ebuild,v 1.1 2007/03/08 18:23:14 beandog Exp $

DESCRIPTION="An alternative to the FLAC reference encoder, with the goal of increasing encoding speed and implementing experimental features. Standalone version of the ffmpeg flac encoder."
HOMEPAGE="http://flake-enc.sourceforge.net/"
SRC_URI="mirror://sourceforge/flake-enc/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

src_compile() {
	cd "${S}"
	./configure --prefix="${D}/usr" || die "configure failed"
	make || die "emake failed"
}

src_install() {
	make install || die "make install failed"
	dodoc Changelog README
}

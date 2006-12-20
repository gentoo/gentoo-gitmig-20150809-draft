# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.31.ebuild,v 1.6 2006/12/20 18:15:29 gustavoz Exp $

inherit eutils

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com/"
SRC_URI="http://www.wavpack.com/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix header files which will be installed
	edos2unix md5.h unpack3.h wputils.h wavpack.h
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
}

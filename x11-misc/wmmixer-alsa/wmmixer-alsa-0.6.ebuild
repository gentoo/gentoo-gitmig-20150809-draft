# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmmixer-alsa/wmmixer-alsa-0.6.ebuild,v 1.1 2002/02/07 08:09:45 vitaly Exp $

S=${WORKDIR}/${P}

DESCRIPTION=""
SRC_URI="http://bohemians.org/~iznogood/wmmixer-alsa/${P}.tar.gz"
HOMEPAGE="http://bohemians.org/~iznogood/"
DEPEND="virtual/glibc x11-base/xfree media-libs/alsa-lib"

src_compile() {
	emake || die
}

src_install () {
	dodoc README COPYING
	dobin wmmixer-alsa
}

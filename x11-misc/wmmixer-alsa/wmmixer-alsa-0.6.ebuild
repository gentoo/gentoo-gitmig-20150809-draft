# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmmixer-alsa/wmmixer-alsa-0.6.ebuild,v 1.2 2002/07/04 00:56:06 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION=""
SRC_URI="http://bohemians.org/~iznogood/wmmixer-alsa/${P}.tar.gz"
HOMEPAGE="http://bohemians.org/~iznogood/"
DEPEND="virtual/x11 
	=media-libs/alsa-lib-0.5*"

src_compile() {
	emake || die
}

src_install () {
	dodoc README COPYING
	dobin wmmixer-alsa
}

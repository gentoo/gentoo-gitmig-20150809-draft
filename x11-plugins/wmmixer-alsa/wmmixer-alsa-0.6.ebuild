# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmixer-alsa/wmmixer-alsa-0.6.ebuild,v 1.1 2002/08/30 07:44:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A hacked version of wmmixer by Sam Hawker to make it use ALSA in stead of the OSS sound drivers in the linux kernel."
SRC_URI="http://bohemians.org/~iznogood/wmmixer-alsa/${P}.tar.gz"
HOMEPAGE="http://bohemians.org/~iznogood/"

DEPEND="virtual/x11 
	=media-libs/alsa-lib-0.5*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake || die
}

src_install () {
	dodoc README COPYING
	dobin wmmixer-alsa
}

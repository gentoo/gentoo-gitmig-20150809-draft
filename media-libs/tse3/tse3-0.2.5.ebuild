# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/tse3/tse3-0.2.5.ebuild,v 1.2 2003/07/12 18:06:10 aliz Exp $

S="${WORKDIR}/tse3-0.2.5"
IUSE="alsa oss arts"
DESCRIPTION="TSE3 Sequencer library"
SRC_URI="mirror://sourceforge/tse3/${P}.tar.gz"
HOMEPAGE="http://TSE3.sourceforge.net/"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="alsa? ( media-libs/alsa-lib )
        arts? ( kde-base/arts )"

src_compile() {
	local myconf=""
    
    use arts || myconf="$myconf --without-arts"
    use alsa || myconf="$myconf --without-alsa"
    use oss || myconf="$myconf --without-oss"
    ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
        $myconf || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO Version
}

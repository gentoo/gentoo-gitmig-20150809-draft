# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-4.0.9.ebuild,v 1.2 2003/05/16 13:20:58 lordvan Exp $

MY_P=${P/\./-}
DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.all-day-breakfast.com/rosegarden/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=gcc-2.9
        >=kdelibs-3.0
	kdemultimedia
        >=qt-3.0
        >=alsa-driver-0.9.2
        virtual/jack
        >=ladspa-sdk-1.0
        >=ladspa-cmt-1.14"

S=${WORKDIR}/${MY_P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
                --infodir=/usr/share/info \
                --mandir=/usr/share/man \
                --with-jack \
                --with-ladspa || die "./configure failed"
	emake || die
}

src_install() {
	einstall 
}

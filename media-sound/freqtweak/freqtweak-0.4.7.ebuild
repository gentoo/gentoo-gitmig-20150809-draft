# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

S=${WORKDIR}/${P}
DESCRIPTION="FreqTweak is a tool for FFT-based realtime audio spectral manipulation and display."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/freqtweak/${P}.tar.gz"
HOMEPAGE="http://freqtweak.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="x11-libs/wxGTK \
        dev-libs/fftw \
        virtual/jack"
	
src_compile() {

	econf || die

	emake || die
}

src_install() {
	
	make DESTDIR=${D} install || die
}


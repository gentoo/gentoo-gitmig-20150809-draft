# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Bandlimited LADSPA Oscillator Plugins"
SRC_URI="mirror://sourceforge/blop/${P}.tar.gz"
HOMEPAGE="http://blop.sf.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-libs/ladspa-sdk-1.12"

src_compile() {
	econf --with-ladspa-prefix=/usr || die
	emake || die
}

src_install() {
	
	make DESTDIR=${D} install || die
}

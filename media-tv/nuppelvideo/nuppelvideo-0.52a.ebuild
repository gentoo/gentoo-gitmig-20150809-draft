# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuppelvideo/nuppelvideo-0.52a.ebuild,v 1.1 2003/09/02 14:36:35 phosphan Exp $

MY_P=NuppelVideo-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="NuppelVideo is a simple low consuming and fast capture program for bttv-cards (BT8x8)"
HOMEPAGE="http://frost.htu.tuwien.ac.at/~roman/nuppelvideo/"
SRC_URI="http://frost.htu.tuwien.ac.at/~roman/nuppelvideo/${MY_P}.tar.gz"
LICENSE="GPL-2 as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND="virtual/os-headers"
RDEPEND=""

src_compile() {
	emake || die
}

src_install() {
	dodoc README LICENSE*
	dobin nuvrec nuvplay nuvedit nuv2mpg nuv2vbr
}
pkg_postinst(){
	einfo
	einfo "If you experience problems with audio, please check:"
	einfo "http://frost.htu.tuwien.ac.at/~roman/nuppelvideo/Sound-Howto.txt"
	einfo
	einfo "If you have bad tv reception you can fix sync problems with:"
	einfo "http://frost.htu.tuwien.ac.at/~roman/nuppelvideo/nuvrepairsync.tcl"
	einfo
}

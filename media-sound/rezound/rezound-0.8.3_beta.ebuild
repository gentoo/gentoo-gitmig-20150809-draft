# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rezound/rezound-0.8.3_beta.ebuild,v 1.4 2003/09/10 22:38:04 msterret Exp $

MY_P="${P/_/}"
DESCRIPTION="Sound editor and recorder"
HOMEPAGE="http://rezound.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

IUSE="oggvorbis"

DEPEND="virtual/x11
	virtual/jack
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	>=dev-libs/fftw-2.1.3-r1
	>x11-libs/fox-1.0.17"

S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure --enable-jack --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog FAQ README TODO
}

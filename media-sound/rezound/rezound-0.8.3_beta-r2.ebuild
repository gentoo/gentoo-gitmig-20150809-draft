# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rezound/rezound-0.8.3_beta-r2.ebuild,v 1.3 2004/01/28 03:22:49 raker Exp $

MY_P="${P/_/}"
DESCRIPTION="Sound editor and recorder"
HOMEPAGE="http://rezound.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="oggvorbis jack"

DEPEND="virtual/x11
	jack? ( virtual/jack )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	=dev-libs/fftw-2*
	>x11-libs/fox-1.0.17
	>=media-libs/flac-1.1.0"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf="--prefix=/usr --host=${CHOST}"
	use jack && myconf="${myconf} --enable-jack"
	./configure ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog FAQ README TODO
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rezound/rezound-0.9.0_beta.ebuild,v 1.4 2004/03/24 23:19:06 mholzer Exp $

MY_P="${P/_/}"
DESCRIPTION="Sound editor and recorder"
HOMEPAGE="http://rezound.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

IUSE="oggvorbis jack nls static oss cdr"

DEPEND="virtual/x11
	jack? ( virtual/jack )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	cdr? ( app-cdr/cdrdao )
	=dev-libs/fftw-2*
	>=x11-libs/fox-1.0.40
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/ladspa-cmt-1.15
	>=media-libs/portaudio-18
	>=media-libs/flac-1.1.0"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf="--prefix=/usr --host=${CHOST} --with-gnu-ld"
	use jack || myconf="${myconf} --disable-jack"
	use static && myconf="${myconf} --enable-standalone"
	use oss && myconf="${myconf} --enable-oss"
	use nls || myconf="${myconf} --disable-nls"

	./configure ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog FAQ README TODO
}


# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openal/openal-20040218.ebuild,v 1.2 2004/02/19 15:31:16 wolf31o2 Exp $

IUSE="alsa arts esd sdl debug oggvorbis mpeg"
DESCRIPTION="OpenAL, the Open Audio Library, is an open, vendor-neutral, cross-platform API for interactive, primarily spatialized audio"
SRC_URI="mirror://gentoo/openal-20040218.tar.bz2"
HOMEPAGE="http://opensource.creative.com/"

S=${WORKDIR}/${P}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x86? ( dev-lang/nasm )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )
	oggvorbis? ( media-libs/libvorbis )
	mpeg? ( media-libs/smpeg )"

src_compile() {
	local myconf

	use esd && myconf="${myconf} --enable-esd"
	use sdl && myconf="${myconf} --enable-sdl"
	use alsa && myconf="${myconf} --enable-alsa"
	use arts && myconf="${myconf} --enable-arts"
	use mpeg && myconf="${myconf} --enable-smpeg"
	use oggvorbis && myconf="${myconf} --enable-vorbis"
	use debug && myconf="${myconf} --enable-debug-maximus"

	cd ${S}/linux
	use alsa && epatch ${FILESDIR}/${P}-alsa_capture.diff
	WANT_AUTOCONF_2_5=1 ./autogen.sh || die
	./configure  --prefix=/usr ${myconf} --enable-paranoid-locks --enable-capture || die
	emake all || die
}

src_install() {
	cd ${S}/linux

	make install DESTDIR=${D}/usr/|| die

	dodoc CREDITS ChangeLog INSTALL NOTES PLATFORM TODO
	dodoc ${FILESDIR}/openalrc
	makeinfo doc/openal.texi
	doinfo doc/openal.info

	cd ${S}
	dodoc CHANGES COPYING CREDITS
	dohtml docs/*.html
}

post_install() {
	einfo "There is a sample openalrc file in /usr/share/doc/${P} which sets up"
	einfo "4 speaker surround sound with ALSA.  Simply copy it to your ~/.openalrc"
	einfo "to use it."
}

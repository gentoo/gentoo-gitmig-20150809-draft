# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openal/openal-20040817.ebuild,v 1.5 2004/11/01 19:48:30 corsair Exp $

inherit eutils gnuconfig

IUSE="alsa arts esd sdl debug oggvorbis mpeg"
DESCRIPTION="OpenAL, the Open Audio Library, is an open, vendor-neutral, cross-platform API for interactive, primarily spatialized audio"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://opensource.creative.com/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc amd64 ~ppc64"

DEPEND="x86? ( dev-lang/nasm )
	alsa? ( >=media-libs/alsa-lib-1.0.2 )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )
	oggvorbis? ( media-libs/libvorbis )
	mpeg? ( media-libs/smpeg )"

src_compile() {
	use ppc64 && gnuconfig_update
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
	epatch ${FILESDIR}/${P}-destdir.patch

	WANT_AUTOCONF=2.5 ./autogen.sh || die
	econf ${myconf} --enable-paranoid-locks \
		--enable-capture --enable-optimize || die
	emake all || die
}

src_install() {
	cd ${S}/linux

	make install DESTDIR="${D}" || die

	dodoc CREDITS ChangeLog INSTALL NOTES PLATFORM TODO
	dodoc ${FILESDIR}/openalrc
	makeinfo doc/openal.texi
	doinfo doc/openal.info

	cd ${S}
	dodoc CHANGES COPYING CREDITS
	dohtml docs/*.html
}

pkg_postinst() {
	einfo "There is a sample openalrc file in /usr/share/doc/${P} which"
	einfo "sets up 4 speaker surround sound with ALSA.  Simply copy it to your:"
	einfo " ~/.openalrc"
	einfo "to use it."
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.8.ebuild,v 1.11 2004/11/22 22:48:46 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc alpha amd64 ia64 arm ~mips"
IUSE="altivec debug doc dvd encode faad imlib mmx oggvorbis sdl static truetype"

DEPEND="encode? ( >=media-sound/lame-3.92 )
	oggvorbis? ( >=media-libs/libvorbis-1.0-r1 )
	doc? ( >=app-text/texi2html-1.64 )
	faad? ( >=media-libs/faad2-1.1 )
	dvd? ( >=media-libs/a52dec-0.7.4 )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	imlib? ( >=media-libs/imlib2-1.0.6 )
	truetype? ( >=media-libs/freetype-2.1.2 )"

src_unpack() {
	unpack ${A} || die
	cd ${S}

	# for some reason it tries to #include <X11/Xlib.h>,b ut doesn't use it
	cd ${S}
	sed -i s:\#define\ HAVE_X11:\#define\ HAVE_LINUX: ffplay.c
}

src_compile() {
	filter-flags -fforce-addr -fPIC
	# fixes bug #16281
	use alpha && append-flags -fPIC
	use amd64 && append-flags -fPIC

	local myconf
	myconf="${myconf} --disable-opts --enable-pp"
	use mmx || myconf="${myconf} --disable-mmx"
	use encode && myconf="${myconf} --enable-mp3lame"
	use oggvorbis && myconf="${myconf} --enable-vorbis"
	use faad && myconf="${myconf} --enable-faad --enable-faadbin"
	use dvd && myconf="${myconf} --enable-a52 --enable-a52bin"
	use static || myconf="${myconf} --enable-shared"
	use sdl || myconf="${myconf} --disable-ffplay"
	use debug || myconf="${myconf} --disable-debug"
	use altivec || myconf="${myconf} --disable-altivec"

	./configure ${myconf} \
		--prefix=/usr || die "./configure failed."
	make || die "make failed."
	use doc && make -C doc all
}

src_install() {
	make \
		DESTDIR=${D} \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

#	emake 	DESTDIR=${D} \
#		MANDIR=${D}/man install || die "Installation failed."
	dosym /usr/bin/ffmpeg /usr/bin/ffplay
	dosym /usr/lib/libavcodec-${PV}.so /usr/lib/libavcodec.so

	dodoc COPYING CREDITS Changelog INSTALL README
	docinto doc
	dodoc doc/TODO doc/*.html doc/*.texi
	insinto /etc
	doins doc/ffserver.conf
}

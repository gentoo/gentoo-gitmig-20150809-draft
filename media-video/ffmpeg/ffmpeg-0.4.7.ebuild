# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.7.ebuild,v 1.4 2004/01/29 23:03:13 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec."
HOMEPAGE="http://ffmpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ~amd64"
IUSE="mmx encode oggvorbis doc faad dvd static sdl imlib truetype"

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

	# fixes a compile on alpha.  This is fixed in upstream cvs
	# http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/ffmpeg/ffmpeg/libavcodec/alpha/dsputil_alpha.c.diff?r1=1.19&r2=1.20
	# so this patch should be removed with the next _pre build
	#epatch ${FILESDIR}/alpha-idct.patch

	epatch ${FILESDIR}/${P}-2.6.patch
}

src_compile() {
	filter-flags -fforce-addr -fPIC
	# fixes bug #16281
	use alpha && append-flags -fPIC

	local myconf

	use mmx || myconf="${myconf} --disable-mmx"
	use encode && myconf="${myconf} --enable-mp3lame"
	use oggvorbis && myconf="${myconf} --enable-vorbis"
	use faad && myconf="${myconf} --enable-faad --enable-faadbin"
	use dvd && myconf="${myconf} --enable-a52 --enable-a52bin"
	use static || myconf="${myconf} --enable-shared"
	use sdl || myconf="${myconf} --disable-ffplay"

	./configure ${myconf} \
		--prefix=/usr || die "./configure failed."
	make || die "make failed."
	use doc && make -C doc all
}

src_install() {
	einstall || die "Installation failed."
	dosym /usr/bin/ffmpeg /usr/bin/ffplay
	dosym /usr/lib/libavcodec-${PV}.so /usr/lib/libavcodec.so

	dodoc COPYING CREDITS Changelog INSTALL README
	docinto doc
	dodoc doc/TODO doc/*.html doc/*.texi
	insinto /etc
	doins doc/ffserver.conf
}

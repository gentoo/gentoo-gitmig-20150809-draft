# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg4ip/mpeg4ip-1.0.ebuild,v 1.10 2005/01/17 19:17:00 tester Exp $

DESCRIPTION="MPEG 4 implementation library"

HOMEPAGE="http://www.mpeg4ip.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MPL-1.1 LGPL-2 GPL-2 LGPL-2.1 BSD UCL MPEG4"

SLOT="0"

KEYWORDS="x86 -amd64"
# not 64 bit safe yet

IUSE="ipv6 mmx gtk"


RDEPEND="media-libs/faac
	>=media-sound/lame-3.92
	gtk? ( >=x11-libs/gtk+-2 )
	mmx? ( >=dev-lang/nasm-0.98.19 )
	media-video/ffmpeg
	!media-libs/faad2"

DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake"


src_unpack() {
	unpack ${A}

	# It searches for ffmpeg in the wrong place
	cp ${S}/configure ${S}/configure.orig
	sed 's:-I\${enable_ffmpeg}/libavcodec:-I/usr/include/ffmpeg:' \
		${S}/configure.orig | \
		sed 's:\${enable_ffmpeg}/libavcodec/libavcodec.a:/usr/lib/libavcodec.so:' \
		> ${S}/configure

	#  Violently rename the private SDL so it doesnt bother the normal version
	for i in lib/SDL/src/Makefile.in \
			lib/SDL/src/main/Makefile.in \
			player/src/Makefile.in \
			server/mp4live/Makefile.in \
			util/iptv/Makefile.in \
			util/yuv/Makefile.in \
			configure; do
		cd ${S}/`dirname ${i}`
		file="`basename ${i}`"
		cp ${file} ${file}.orig || die
		sed -e 's:libSDL:libSDLmpeg4ip:g' ${file}.orig > ${file} || die
	done
}

src_compile() {

	# Configure the private SDL
	cd ${S}/lib/SDL
	econf || die "SDL configure failed"
	cd ${S}

	local myconf
	myconf=" `use_enable ipv6`
			`use_enable mmx`
			` use_enable ppc`"

	econf ${myconf} || die "configure failed"

	# making libsdl first to fix bug #38316, it seems like bug #34804
	cd ${S}/lib/SDL
	emake || die "make private libSDL failed"
	sed -i "s:-pthread::g" src/libSDLmpeg4ip.la

	cd ${S}
	emake || die "make failed"

}

src_install () {

	# Install only the lib from the private SDL
	cd ${S}/lib/SDL
	make install-lib DESTDIR=${D}

	# It has its own SDL, we have install the libs, ignore the rest
	cd ${S}/lib
	mv Makefile Makefile.orig
	sed -e 's/SDL / /' Makefile.orig > Makefile

	cd ${S}
	einstall || die "make install failed"

}

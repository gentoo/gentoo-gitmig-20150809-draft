# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg4ip/mpeg4ip-1.0.ebuild,v 1.1 2004/01/04 23:34:13 tester Exp $

DESCRIPTION="MPEG 4 implementation library"

HOMEPAGE="http://www.mpeg4ip.net/"

PV2=`echo $PV | sed s/_rc/RC/`

SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV2}.tar.gz"

LICENSE="MPL-1.1 LGPL-2 GPL-2 LGPL-2.1 BSD UCL MPEG4"

SLOT="0"

KEYWORDS="~x86 ~ppc -amd64"
# not 64 bit safe yet

IUSE="ipv6 mmx gtk"

DEPEND="sys-devel/libtool
		sys-devel/autoconf
		sys-devel/automake
		media-libs/faac
		>=media-sound/lame-3.92
		gtk? ( >=x11-libs/gtk+-2 )
		mmx? ( >=dev-lang/nasm-0.98.19 )
		media-video/ffmpeg"

S="${WORKDIR}/${PN}-${PV2}"

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

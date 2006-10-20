# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra-cvs/cinelerra-cvs-20061020.ebuild,v 1.1 2006/10/20 21:31:51 aballier Exp $

inherit toolchain-funcs eutils flag-o-matic

#filter-flags "-fPIC -fforce-addr"

RESTRICT="nostrip"

DESCRIPTION="Cinelerra - Professional Video Editor - Unofficial CVS-version"
HOMEPAGE="http://cvs.cinelerra.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="3dnow alsa esd mmx oss static freetype2 ieee1394 css altivec opengl"
RDEPEND="media-libs/libpng
	>=media-libs/libdv-1.0.0
	media-libs/faad2
	media-libs/faac
	media-libs/a52dec
	media-video/ffmpeg
	>=sci-libs/fftw-3.0.1
	>=media-libs/x264-svn-20060302
	ieee1394? ( media-libs/libiec61883 >=sys-libs/libraw1394-1.2.0 \
		>=sys-libs/libavc1394-0.5.0 )
	media-video/mjpegtools
	esd? ( >=media-sound/esound-0.2.34 )
	freetype2? ( >=media-libs/freetype-2.1.10 )
	opengl? ( virtual/opengl )
	>=media-libs/openexr-1.2.2
	>=media-libs/libvorbis-1.1.0
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_alpha4-r1
	|| ( (
			x11-libs/libX11
			x11-libs/libXv
			x11-libs/libXxf86vm
			x11-libs/libXext
			x11-libs/libXvMC
			x11-libs/libXft
		) virtual/x11 )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

pkg_setup() {
	if [[ "$(gcc-major-version)" -lt "3" ]]; then
		die "You must use gcc 3 or better."
	fi
}

src_compile() {
	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	./autogen.sh
	econf \
	`use_enable static` \
	`use_enable alsa` \
	`use_enable esd` \
	`use_enable oss` \
	`use_enable mmx` \
	`use_enable 3dnow` \
	--with-plugindir=/usr/$(get_libdir)/cinelerra \
	`use_enable freetype2` \
	`use_enable ieee1394 firewire` \
	`use_enable css` \
	`use_enable opengl` \
	`use_enable altivec` \
	|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dohtml -a png,html,texi,sdw -r doc/*
	# workaround
	rm -fR ${D}/usr/include
	mv ${D}/usr/bin/mpeg3cat ${D}/usr/bin/mpeg3cat.hv
	mv ${D}/usr/bin/mpeg3dump ${D}/usr/bin/mpeg3dump.hv
	mv ${D}/usr/bin/mpeg3toc ${D}/usr/bin/mpeg3toc.hv
	ln -s /usr/bin/mpeg2enc ${D}/usr/lib/cinelerra/mpeg2enc.plugin
}

pkg_postinst () {

einfo "Please note that this is unofficial and somewhat experimental code."
einfo "See cvs.cinelerra.org for a list of changes to the official cinelerra"
einfo "release."
}

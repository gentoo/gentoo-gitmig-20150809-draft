# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.12-r2.ebuild,v 1.3 2004/10/21 00:19:27 chriswhite Exp $

inherit libtool flag-o-matic eutils gcc

# dont strip binarys causes missing symbol problems
# with pvm compiles
RESTRICT="nostrip"

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://zebra.fh-weingarten.de/~transcode/"
SRC_URI="http://www.zebra.fh-weingarten.de/~transcode/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc ~amd64"
IUSE="sdl static mpeg mmx sse 3dnow encode X quicktime avi altivec oggvorbis theora pvm"

DEPEND=">=media-libs/a52dec-0.7.4
	=sys-devel/gcc-3*
	>=media-libs/libdv-0.99
	x86? ( >=dev-lang/nasm-0.98.36 )
	>=media-libs/libdvdread-0.9.0
	>=media-video/ffmpeg-0.4.8.20040322-r1
	>=media-libs/xvid-0.9.1
	>=media-video/mjpegtools-1.6.2-r3
	>=dev-libs/lzo-1.08
	>=media-libs/libfame-0.9.1
	>=media-gfx/imagemagick-5.5.6.0
	media-libs/netpbm
	media-libs/libexif
	X? ( virtual/x11 )
	avi? (	>=media-video/avifile-0.7.38.20030710
			x86? ( >=media-libs/divx4linux-20030428 ) )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( virtual/quicktime )
	oggvorbis? ( media-libs/libvorbis
					media-libs/libogg )
	theora? ( media-libs/libtheora )
	pvm? ( >=sys-cluster/pvm-3.4 )"

RDEPEND="${DEPEND}
		app-text/gocr"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PF}-dvdmenu.patch

	[ "$(gcc-version)" == "3.4" ]; epatch ${FILESDIR}/${PF}-gcc34.patch

	if has_version '>=media-libs/netpbm-9.13'; then
		sed -i 's:-lppm:-lnetpbm:' \
			contrib/subrip/Makefile || die
	fi

	# workaround for including avifile haders, which are expected
	# in an directory named "avifile"
	if use avi; then
		avi_inc=$(avifile-config --cflags | sed -e "s|^-I||")
		if [ -d "$avi_inc" ] && [ "$(basename "$avi_inc")" != "avifile" ]
		then
			ln -s "$avi_inc" avifile
		fi
	fi

}

src_compile() {
	local myconf="--disable-dependency-tracking --with-dvdread"

	# Don't build with -mfpmath=sse (Bug #14920)
	filter-mfpmath sse
	filter-flags -maltivec -mabi=altivec -fforce-addr \
	-momit-leaf-frame-pointer -msse2 -fstack-protector

	# doesnt work correctly/fully
	if use static; then
		myconf="${myconf} --enable-static --disable-shared"
	fi

	# BREG error with -fPIC
	# see bug #48699
	# ---
	# really ? no on amd64, and we need -fPIC.
	# Danny van Dyk <kugelfang@gentoo.org> 2004/05/25
	use !amd64 && filter-flags -fPIC -fPIE

	# fix invalid paths in .la files of plugins
	elibtoolize

	if use quicktime; then
		# determine which quicktime lib is used and set correct
		# configure options
		if has_version 'media-libs/openquicktime'; then
			myconf="${myconf} --with-openqt --without-qt"
		else
			myconf="${myconf} --without-openqt --with-qt"
		fi
	fi

	use pvm \
		&& myconf="${myconf} --with-pvm3 \
			--with-pvm3-lib=/usr/local/pvm3/lib/LINUX \
			--with-pvm3-include=/usr/local/pvm3/include"

	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/$(get_libdir)/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postproc/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/$(get_libdir)"

	append-flags -DDCT_YUV_PRECISION=1

	econf \
		$(use_enable sse) \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable altivec) \
		$(use_with avi avifile-mods) \
		$(use_enable avi avifile6) \
		$(use_enable encode lame) \
		$(use_enable mpeg libmpeg3) \
		$(use_with oggvorbis ogg) \
		$(use_with oggvorbis vorbis) \
		$(use_with theora) \
		$(use_enable X x) \
		${myconf} \
		|| die

	einfo "if this fails with broken kde libs, try reemerge avifile"
	# mmx and amd64 is a nono so dont confuse the users
	use !amd64 \
		&& einfo "also add mmx to your USE flags if you cpu supports it"

	emake || die

	# subrip stuff
	cd contrib/subrip
	emake || die

	if use pvm; then
		sed -i -e "s:\${exec_prefix}/bin/pvmgs:\$(DESTDIR)/\${exec_prefix}/bin/pvmgs:" ${S}/pvm3/Makefile || die
	fi
}

src_install () {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO

	# subrip stuff
	dobin contrib/subrip/{pgm2txt,srttool,subtitle2pgm,subtitle2vobsub} || die

	#TODO mv to pkg_*  (needed?)
	#einfo "This ebuild uses subtitles !!!"
}

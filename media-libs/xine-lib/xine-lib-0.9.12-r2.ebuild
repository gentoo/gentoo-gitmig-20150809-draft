# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-0.9.12-r2.ebuild,v 1.2 2002/08/02 16:28:13 aliz Exp $ 

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="http://xine.sourceforge.net/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="oggvorbis? ( media-libs/libvorbis )
	X? ( virtual/x11 )
	avi? ( >=media-libs/win32codecs-0.50 
	       media-libs/divx4linux )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-0.0.3.3
	       >=media-libs/libdvdread-0.9.2 )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	directfb? ( >=dev-libs/DirectFB-0.9.9
		    dev-util/pkgconfig )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_unpack() {

	unpack ${A}
	cd ${S}

	for file in `grep -l -r "xine_logo.mpg" *`; do
		sed -e "s:xine_logo.mpg:xine_logo.mpv:g" ${file} \
		    > ${file}.hacked || die
		mv ${file}.hacked ${file} || die
	done

	patch -p1 < ${FILESDIR}/xine-lib-configure.patch || die "patch 1 failed"

	use directfb && ( \
		patch -p0 < ${FILESDIR}/xineconfig.patch-${PV} || die "patch 2 failed"
		patch -p2 < ${FILESDIR}/${P}-r2-directfb.patch || die "patch failed"
	) || patch -p1 < ${FILESDIR}/xine-lib-disable-directfb.patch || die "patch 2 failed"
}

src_compile() {

	elibtoolize

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X \
		|| myconf="${myconf} --disable-x11 --disable-xv"
	use esd	\
		|| myconf="${myconf} --disable-esd --disable-esdtest"
	use nls	\
		|| myconf="${myconf} --disable-nls"
	use alsa \
		|| myconf="${myconf} --disable-alsa --disable-alsatest"
	use arts \
		|| myconf="${myconf} --disable-arts --disable-artstest"

	# This breaks because with the test disabled, it defaults to "found" check with
	# the next release until then let it autodetect.  See bug #2377.
	# use aalib  || myconf="${myconf} --disable-aalib --disable-aalibtest"

	# Configure script is broken, even if you pass the flags below it still assumes
	# ogg is installed and tries to compile it, giving you bug #5244. But leaving
	# ogg for autodetection works.
	#use oggvorbis \
	#	|| myconf="${myconf} \
	#		 --disable-ogg \
	#		 --disable-oggtest \
	#		 --disable-vorbis \
	#		 --disable-vorbistest"
	
	use avi	\
		&& myconf="${myconf} --with-w32-path=/usr/lib/win32" \
		|| myconf="${myconf} --disable-asf"

	# This is ``fixes'' compilation problems when em8300 libs installed
	# The proper fix is to follow.
	# myconf="${myconf} --disable-dxr3 --disable-dxr3test"

	econf ${myconf} || die
		    
	emake || die
}

src_install() {
	
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia README*

}

pkg_postinst() {

	einfo
	einfo "Please note, a new version of xine-lib has been installed,"
	einfo "for library consistency you need to unmerge old versions"
	einfo "of xine-lib before merging xine-ui."
	einfo

}

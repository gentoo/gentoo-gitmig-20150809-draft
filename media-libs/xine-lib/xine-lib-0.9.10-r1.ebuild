# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-0.9.10-r1.ebuild,v 1.4 2002/07/16 11:36:53 seemant Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://xine.sourceforge.net/files/xine-lib-${PV}.tar.gz"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="X? ( virtual/x11 )
	avi? ( >=media-libs/win32codecs-0.50 
	       media-libs/divx4linux )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-0.0.3.3
	       >=media-libs/libdvdread-0.9.2 )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	oggvorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 ppc"

src_unpack() {

unpack xine-lib-${PV}.tar.gz
patch -p0 < ${FILESDIR}/xineconfig.patch

}

src_compile() {

	libtoolize --copy --force

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use esd    || myconf="${myconf} --disable-esd --disable-esdtest"
	use nls    || myconf="${myconf} --disable-nls"
	use alsa   || myconf="${myconf} --disable-alsa --disable-alsatest"
	use arts   || myconf="${myconf} --disable-arts --disable-artstest"
	# This breaks because with the test disabled, it defaults to "found" check with
	# the next release until then let it autodetect.  See bug #2377.
	# use aalib  || myconf="${myconf} --disable-aalib --disable-aalibtest"

	use oggvorbis || myconf="${myconf}
				 --disable-ogg
				 --disable-oggtest
				 --disable-vorbis
				 --disable-vorbistest"
	
	use avi	&& myconf="${myconf}
			   --with-w32-path=/usr/lib/win32" \
		|| myconf="${myconf}
			   --disable-asf"

	# This is ``fixes'' compilation problems when em8300 libs installed
	# The proper fix is to follow.
	# myconf="${myconf} --disable-dxr3 --disable-dxr3test"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		${myconf} || die
		    
	emake || die
}

src_install() {
	
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia README*

}

pkg_postinst() {

	einfo
	einfo "Please note, a new version of xine-lib has been installed,"
	einfo "for library consistency you need to unmerge old versions"
	einfo "of xine-lib before merging xine-ui."
	einfo "Please also note that xine-d4d and xine-d5d plugins are"
	einfo "not yet compatible with this new library."
	einfo

}

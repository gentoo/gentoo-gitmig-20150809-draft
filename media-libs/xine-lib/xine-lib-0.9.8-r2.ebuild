# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-0.9.8-r2.ebuild,v 1.1 2002/04/12 13:50:03 seemant Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://xine.sourceforge.net/files/xine-lib-${PV}.tar.gz"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND=">=media-libs/aalib-1.4_rc3
	X? ( virtual/x11 )
	avi? ( >=media-libs/win32codecs-0.50 )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-0.0.3.3
		>=media-libs/libdvdread-0.9.2 )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	oggvorbis? ( media-libs/libvorbis )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use esd    || myconf="${myconf} --disable-esd --disable-esdtest"
	use nls    || myconf="${myconf} --disable-nls"
	use alsa   || myconf="${myconf} --disable-alsa --disable-alsatest"
	use arts   || myconf="${myconf} --disable-arts --disable-artstest"
#	use aalib  || myconf="${myconf} --disable-aalib --disable-aalibtest" 

	use oggvorbis	\
		|| myconf="${myconf} --disable-ogg --disable-oggtest --disable-vorbis --disable-vorbistest"
	
	use avi	\
		&& myconf="${myconf} --with-w32-path=/usr/lib/win32"	\
		|| myconf="${myconf} --disable-asf"
	 
	./configure --host=${CHOST} 			\
		--prefix=/usr			\
		--mandir=/usr/share/man		\
		--infodir=/usr/share/info		\
		--sysconfdir=/etc			\
		${myconf} || die
		    
	emake || die
}

src_install() {
	
	make prefix=${D}/usr						\
		mandir=${D}/usr/share/man					\
		infodir=${D}/usr/share/info				\
		docdir=${D}/usr/share/doc/${PF}/html			\
		sysconfdir=${D}/etc					\
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia README*

}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-0.9.8.ebuild,v 1.1 2002/02/12 19:23:33 verwilst Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://xine.sourceforge.net/files/xine-lib-${PV}.tar.gz"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-0.0.3.3
	>=media-libs/libdvdread-0.9.2
	>=media-libs/win32codecs-0.50
	>=media-libs/aalib-1.4_rc3
	X? ( virtual/x11 )
	esd? ( media-sound/esound )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )
	ogg? ( media-libs/libogg )
	vorbis? ( media-libs/libvorbis )"


src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use alsa   || myconf="${myconf} --disable-alsa --disable-alsatest"
	use esd    || myconf="${myconf} --disable-esd --disable-esdtest"
#	use aalib  || myconf="${myconf} --disable-aalib --disable-aalibtest" 
	use arts   || myconf="${myconf} --disable-arts --disable-artstest"
	use ogg    || myconf="${myconf} --disable-ogg --disable-oggtest"
	use vorbis || myconf="${myconf} --disable-vorbis --disable-vorbistest"
	 
	./configure --host=${CHOST} 			\
		    --prefix=/usr			\
		    --mandir=/usr/share/man		\
		    --infodir=/usr/share/info		\		    --sysconfdir=/etc			\
		    --with-w32-path=/usr/lib/win32	\
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




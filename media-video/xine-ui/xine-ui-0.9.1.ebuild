# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://skyblade.homeip.net/xine/XINE-${PV}/source.TAR.BZ2s/xine-ui-${PV}.tar.bz2"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-0.0.3
	>=media-libs/libdvdread-0.9.1
	>=media-video/xine-lib-0.9.1
	X? ( virtual/x11 )
	esd? ( media-sound/esound )
	aalib? ( media-libs/aalib )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )"

RDEPEND="$DEPEND"


src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X     || myconf="${myconf} --disable-x11 --disable-xv"
	use alsa  || myconf="${myconf} --disable-alsa --disable-alsatest"
	use esd   || myconf="${myconf} --disable-esd --disable-esdtest"
	use aalib || myconf="${myconf} --disable-aalib --disable-aalibtest"
	use arts  || myconf="${myconf} --disable-arts --disable-artstest"
  
	./configure --prefix=/usr --mandir=/usr/share/man $myconf --host=${CHOST} || die
	make || die
}

src_install () {
	
	make  DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	cd ${S}/doc
	dodoc bug_report_form FAQ* README*
	
}


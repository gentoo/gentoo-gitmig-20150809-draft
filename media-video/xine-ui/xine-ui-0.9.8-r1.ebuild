# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.8-r1.ebuild,v 1.1 2002/02/19 19:52:02 azarah Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://xine.sourceforge.net/files/xine-ui-${PV}.tar.gz"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	media-libs/libpng
	media-libs/aalib
	>=media-libs/xine-lib-${PV}
	X? ( virtual/x11 )"
#	aalib? ( media-libs/aalib )"


src_unpack() {

	unpack xine-ui-${PV}.tar.gz
	cd ${S}
	patch -p1 <${FILESDIR}/xine-ui-gentoo.diff || die
}

src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
#	use aalib  || myconf="${myconf} --disable-aalib --disable-aalibtest"
  
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --infodir=/usr/share/info \
		    --sysconfdir=/etc \
		    ${myconf} || die
			
	emake || die
}

src_install() {
	
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}




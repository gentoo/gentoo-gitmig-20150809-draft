# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle/ogle-0.8.2-r6.ebuild,v 1.2 2002/04/27 17:54:13 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ogle is a full featured DVD player that supports DVD menus"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND="media-libs/libdvdcss
		media-libs/jpeg 
		>=dev-libs/libxml2-2.4.19
		media-libs/libdvdread 
		=media-libs/a52dec-0.7.2
		x11-base/xfree"

src_compile() {

	# STOP!  If you make any changes, make sure to unmerge all copies
	# of ogle and ogle-gui from your system and merge ogle-gui using your
	# new version of ogle... Changes in this package can break ogle-gui
	# very very easily -- blocke

	local myconf
	
	use mmx || myconf="--disable-mmx"
	use oss || myconf="${myconf} --disable-oss"

	libtoolize --copy --force

	# configure needs access to the updated CFLAGS
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml -I/usr/include/libxml2"

	./configure --prefix=/usr --enable-shared --sysconfdir=/etc --host=${CHOST}  || die
	emake CFLAGS="${CFLAGS}" || die	

}

src_install() {
	
  make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info docdir=${D}/usr/share/doc/${PF}/html sysconfdir=${D}/etc install || die
  dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS README TODO doc/liba52.txt

}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.24.1-r1.ebuild,v 1.2 2001/10/06 20:15:36 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Vector illustrating application for GNOME"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${A}"
HOMEPAGE="http://sodipodi.sourceforge.net/"

RDEPEND=">=gnome-base/gnome-print-0.30
         >=gnome-extra/gal-0.13-r1
	 bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-compile.patch
	automake
}

src_compile() {
	local myconf

	if [ "`use bonobo`" ] ; then
		myconf="--with-bonobo"
	else
		myconf="--without-bonobo"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="$myconf --disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr			 		\
	            --sysconfdir=/etc		 			\
		    --enable-gnome					\
		    --enable-gnome-print ${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/sodipodi/sodipodi-0.24.ebuild,v 1.1 2001/09/28 13:26:12 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Vector illustrating application for GNOME"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${A}"
HOMEPAGE="http://sodipodi.sourceforge.net/"

RDEPEND=">=gnome-base/gnome-print-0.21 
         >=gnome-base/gal-0.4
	 bonobo? ( >=gnome-base/bonobo-0.37 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

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

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
	            --sysconfdir=/etc/opt/gnome 			\
		    --enable-gnome --enable-gnome-print ${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

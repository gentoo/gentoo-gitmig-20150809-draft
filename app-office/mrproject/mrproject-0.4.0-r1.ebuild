# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.4.0-r1.ebuild,v 1.2 2001/10/06 20:15:36 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Project management application for GNOME"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${A}"
HOMEPAGE="http://mrproject.codefactory.se/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/ORBit-0.5.10-r1
         >=gnome-extra/gal-0.13-r1
	 >=gnome-base/bonobo-1.0.9-r1
	 >=gnome-base/libglade-0.17-r1
	 >=dev-libs/libxml-1.8.15
	 >=gnome-base/gconf-1.0.4-r2
	 >=gnome-base/gnome-vfs-1.0.2-r1
	 >=gnome-base/oaf-0.6.6-r1
	 >=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/xml-i18n-tools-0.8.4"


src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-compile.patch
	automake
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr 					\
		    --sysconfdir=/etc					\
		    --disable-more-warnings 				\
		    --without-python $myconf || die

	emake || die
}

src_install () {
    try make DESTDIR=${D} install

    dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}




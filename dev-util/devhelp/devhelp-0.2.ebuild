# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.2.ebuild,v 1.2 2001/10/22 10:12:02 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Developer help browser"
SRC_URI="http://devhelp.codefactory.se/download/${P}.tar.gz"
HOMEPAGE="http://devhelp.codefactory.se/"

RDEPEND=">=gnome-base/gnome-libs-1.2.8
	 >=gnome-base/ORBit-0.5.10-r1
	 >=gnome-base/bonobo-1.0.9-r1
	 >=gnome-base/libglade-0.17-r1
	 >=dev-libs/libxml-1.8.15
	 >=gnome-base/gconf-1.0.4-r2
	 >=gnome-base/gnome-vfs-1.0.2-r1
	 >=gnome-base/oaf-0.6.6-r1
	 >=gnome-base/gnome-print-0.30"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

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




# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.88.1-r1.ebuild,v 1.2 2001/11/10 03:03:57 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

RDEPEND=">=dev-libs/libxml-1.8.15
         >=media-libs/gdk-pixbuf-0.11.0-r1
         >=dev-libs/popt-1.5
	 bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
#	python? ( dev-lang/python-2.0 )"

src_compile() {
	local myconf

	if [ "`use gnome`" ] ; then
        	myconf="--enable-gnome"
	fi

	if [ "`use bonobo`" ]; then
     		myconf="--enable-gnome --enable-bonobo"
    	fi

#    if [ "`use python`" ] ; then
#      myconf="$myconf --with-python"
#    fi

	if [ -z "`use nls`" ] ; then
        	myconf="$myconf --disable-nls"
    	fi
 
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    ${myconf} || die

        # enable-gnome-print not recoomended

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}

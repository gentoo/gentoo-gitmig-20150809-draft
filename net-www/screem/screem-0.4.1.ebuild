# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/net-www/screem/screem-0.4.1.ebuild,v 1.2 2001/08/07 16:18:10 csjoly Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
SRC_URI="http://ftp1.sourceforge.net/screem/${P}.tar.gz"
HOMEPAGE="http://www.screem.org"

DEPEND=">=gnome-base/gnome-libs-1.2.0
		>=gnome-base/libxml-1.8.7
		>=gnome-base/libglade-0.12
		>=gnome-base/gdk-pixbuf-0.7
		nls? ( sys-devel/gettext )"

src_compile() {

	if [ -z "`use nls`" ]
	then
		myopts="--disable-nls"
	fi

	if [ "`use ssl`" ]
	then
		myopts="$myopts --with-ssl"
	fi

	cp ${FILESDIR}/Makefile.in intl/Makefile.in

    try ./configure --prefix=/opt/gnome --host=${CHOST} ${myopts}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog DEPENDS FAQ INSTALL
	dodoc NEWS README TODO
}


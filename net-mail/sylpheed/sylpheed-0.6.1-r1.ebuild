# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed/sylpheed-0.6.1-r1.ebuild,v 1.1 2001/09/12 05:12:29 blocke Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/sylpheed/${A}"
HOMEPAGE="http://sylpheed.good-day.net"

DEPEND=">=x11-libs/gtk+-1.2
        >=media-libs/compface-1.4
	gnome? ( >=media-libs/gdk-pixbuf-0.10 )
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	gpg? ( >=app-crypt/gnupg-1.0.6 >=app-crypt/gpgme-0.2.2 )" 


RDEPEND=">=x11-libs/gtk+-1.2
	gnome? ( >=media-libs/gdk-pixbuf-0.10 )
	ssl? ( dev-libs/openssl )
	gpg? ( >=app-crypt/gnupg-1.0.6 >=app-crypt/gpgme-0.2.2 )"

src_compile() {

    local myconf
    if [ -z "`use gnome`" ] ; then
		myconf="--disable-gdk-pixbuf --disable-imlib"
    fi
    if [ -z "`use nls`" ] ; then
		myconf="$myconf --disable-nls"
    fi
    if [ "`use ssl`" ] ; then
		myconf="$myconf --enable-ssl"
    fi
	if [ "`use gpg`" ] ; then
		myconf="$myconf --enable-gpgme"
    fi

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --enable-ipv6 $myconf
    try make

}

src_install () {

    try make prefix=${D}/usr manualdir=${D}/usr/share/doc/${PF}/html install
    dodoc AUTHORS COPYING ChangeLog* NEWS README* TODO*

}


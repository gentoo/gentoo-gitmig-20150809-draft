# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke (blocke@shivan.org)
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-1.2.0-r1.ebuild,v 1.3 2001/10/07 11:11:08 azarah Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Balsa: email client for GNOME"
SRC_URI="http://www.theochem.kth.se/~pawsa/balsa/${A}"
HOMEPAGE="http://www.balsa.net"

DEPEND=">=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/imlib-1.9.10-r1
	>=gnome-base/gnome-core-1.4.0.4-r1
	>=gnome-base/gnome-print-0.30
	>=app-text/pspell-0.11.2
	>=net-libs/libesmtp-0.8.3
	>=gnome-extra/gtkhtml-0.14.0-r1
	>=dev-libs/libpcre-3.4
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

RDEPEND="${DEPEND}"

src_compile() {

    local myconf

# FIXME: won't build without nls... ugh... configure script braindamage
#    if [ -z "`use nls`" ] ; then
#	myconf="$myconf --disable-nls"
#    fi

     if [ "`use ssl`" ] ; then
	myconf="$myconf --with-ssl"
     fi

    try libmutt/configure --prefix=/usr --host=${CHOST} --with-mailpath=/var/mail
    try ./configure --prefix=/usr --host=${CHOST} --enable-threads --enable-gtkhtml --enable-pcre $myconf
    make || die
}

src_install () {
    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*
}


# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed/sylpheed-0.7.2.ebuild,v 1.1 2002/02/21 21:34:53 tod Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/sylpheed/sylpheed-${PV}.tar.bz2"
HOMEPAGE="http://sylpheed.good-day.net"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	>=media-libs/compface-1.4
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	gpg? ( >=app-crypt/gnupg-1.0.6 >=app-crypt/gpgme-0.2.3 )" 


RDEPEND=">=x11-libs/gtk+-1.2.10-r4
	gnome? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )
	ssl? ( dev-libs/openssl )
	gpg? ( >=app-crypt/gnupg-1.0.6 >=app-crypt/gpgme-0.2.3 )"

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

	./configure --prefix=/usr \
		 --host=${CHOST}  \
		 --enable-ipv6 $myconf || die
	make || die
}

src_install () {

	make	prefix=${D}/usr \
		manualdir=${D}/usr/share/doc/${PF}/html \
		install || die
	dodoc AUTHORS COPYING ChangeLog* NEWS README* TODO*
}


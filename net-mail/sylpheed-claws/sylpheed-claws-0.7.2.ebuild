# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed-claws/sylpheed-claws-0.7.2.ebuild,v 1.1 2002/02/22 15:24:26 tod Exp $

S=${WORKDIR}/sylpheed-${PV}claws
DESCRIPTION="Bleeding edge version of Sylpheed"
SRC_URI="http://prdownloads.sourceforge.net/sylpheed-claws/sylpheed-${PV}claws.tar.gz"
HOMEPAGE="http://sylpheed-claws.sf.net"

DEPEND=">=x11-libs/gtk+-1.2.6
	ssl? ( >=dev-libs/openssl-0.9.6b )
	ldap? ( >=net-nds/openldap-2.0.7 )
	pixbuf? ( >=media-libs/gdk-pixbuf-0.16 )
	spell? ( >=app-text/pspell-0.12.2 )
	xface? ( >=media-libs/compface-1.4 )
	jpilot? ( >=app-misc/jpilot-0.99 )
	imlib? ( >=media-libs/imlib-1.9.10 )
	gpgme? ( >=app-crypt/gpgme/0.2.3 )
	"
	
RDEPEND="$DEPEND"

src_compile() {
	local myconf

	use ssl && \
		myconf="$myconf --enable-ssl" || \
		myconf="$myconf --disable-ssl"

	use gpgme && \
		myconf="$myconf --enable-gpgme" || \
		myconf="$myconf --disable-gpgme"

	use pixbuf && \
		myconf="$myconf --enable-gtk-pixbuf" || \
		myconf="$myconf --disable-gtk-pixbuf"

	use xface && \
		myconf="$myconf --enable-compface" || \
		myconf="$myconf --disable-compface"

	use ldap && \
		myconf="$myconf --enable-ldap" || \
		myconf="$myconf --disable-ldap"

	use spell && \
		myconf="$myconf --enable-pspell" || \
		myconf="$myconf --disable-pspell"

	use ipv6 && 
		myconf="$myconf --enable-ipv6" || \
		myconf="$myconf --disable-ipv6"

	use jpilot && \
		myconf="$myconf --enable-jpilot" || \
		myconf="$myconf --disable-jpilot"

	use imlib && \
		myconf="$myconf --enable-imlib" || \
		myconf="$myconf --disable-imlib"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	if [ -z "`use gnome`" ] ; then
		rm -rf ${D}/usr/share/gnome
	fi
}

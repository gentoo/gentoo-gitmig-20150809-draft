# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke (blocke@shivan.org)
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-1.2.4-r1.ebuild,v 1.2 2002/05/23 06:50:16 seemant Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Balsa: email client for GNOME"
SRC_URI="http://www.theochem.kth.se/~pawsa/balsa/${A}"
HOMEPAGE="http://www.balsa.net"

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
	>=gnome-base/gnome-core-1.4.0.4-r1
	>=gnome-base/gnome-print-0.30
	>=gnome-base/ORBit-0.5.10-r1
	>=media-libs/gdk-pixbuf-0.13.0
	>=app-text/pspell-0.11.2
	>=net-libs/libesmtp-0.8.6
	>=dev-libs/libpcre-3.4
	gtkhtml? ( >=gnome-extra/gtkhtml-0.16.1 )
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"



src_unpack() {
	unpack ${P}.tar.bz2
	# this patch is from Riccardo Persichetti
	# (ricpersi@libero.it) to make balsa compile
	patch -p0 < ${FILESDIR}/balsa-1.2.4.diff
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="$myconf --disable-nls"
	fi

	if [ "`use ssl`" ] ; then
		myconf="$myconf --with-ssl"
	fi

	if [ "`use gtkhtml`" ] ; then
		myconf="$myconf --with-gtkhtml"
	fi

	libmutt/configure --prefix=/usr --host=${CHOST} --with-mailpath=/var/mail
	assert "configure libmutt failed"
	./configure --prefix=/usr --host=${CHOST} --enable-threads --enable-pcre $myconf
	assert "configure balsa failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO docs/*
}


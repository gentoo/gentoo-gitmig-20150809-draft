# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2  
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-1.4.3.ebuild,v 1.3 2003/05/03 02:43:01 weeve Exp $

IUSE="ssl nls cups gtkhtml spell perl"

S=${WORKDIR}/${P}
DESCRIPTION="Balsa: email client for GNOME"
SRC_URI="http://www.theochem.kth.se/~pawsa/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.balsa.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
	>=gnome-base/gnome-libs-1.4.1.4
	>=gnome-base/ORBit-0.5.10-r1
	>=media-libs/gdk-pixbuf-0.13.0
	>=net-libs/libesmtp-0.8.11
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	cups? ( >=gnome-base/gnome-print-0.30 )
	perl? ( >=dev-libs/libpcre-3.4 )
	spell? ( virtual/aspell-dict )
	gtkhtml? ( >=gnome-extra/gtkhtml-0.16.1 )"

src_unpack() {
	unpack ${A}

	# Patch to use the new aspell instead of the old, crusty pspell modules
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.4.0-gentoo.diff
}

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use ssl && myconf="${myconf} --with-ssl"
	use gtkhtml && myconf="${myconf} --enable-gtkhtml"
	use perl && myconf="${myconf} --enable-pcre"
	use spell && myconf="${myconf} --with-aspell=yes"

	myconf="${myconf} --with-mailpath=/var/mail --enable-threads"

	autoconf || die
	econf ${myconf} || die "configure balsa failed"
	emake || die "emake failed"
}

src_install () {
	local myinst
	myinst="gnomeconfdir=${D}/etc \
		gnomedatadir=${D}/usr/share"

	einstall ${myinst} || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO
	docinto docs
	dodoc docs/*
}

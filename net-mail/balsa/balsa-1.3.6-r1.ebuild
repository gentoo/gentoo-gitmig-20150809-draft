# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Modified by Riccardo Persichetti (ricpersi@libero.it)
# /space/gentoo/cvsroot/gentoo-x86/net-mail/balsa/balsa-1.3.5-r1.ebuild,v 1.2 2002/05/23 06:50:16 seemant Exp

S=${WORKDIR}/${P}
DESCRIPTION="Balsa: email client for GNOME"
SRC_URI="http://www.theochem.kth.se/~pawsa/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.balsa.net"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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
	spell? ( >=app-text/pspell-0.11.2 )
	gtkhtml? ( >=gnome-extra/gtkhtml-0.16.1 )"

src_unpack() {
	 unpack ${P}.tar.bz2
	# this patch is from Riccardo Persichetti
	# (ricpersi@libero.it) to make balsa compile
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use ssl && myconf="${myconf} --with-ssl"
	use gtkhtml && myconf="${myconf} --with-gtkhtml"
	use perl && myconf="${myconf} --enable-pcre"
	use spell && myconf="${myconf} --enable-all"

	libmutt/configure --prefix=/usr \
		--host=${CHOST} \
		--with-mailpath=/var/mail || die "configure libmutt failed"

	myconf="${myconf} --enable-threads"

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

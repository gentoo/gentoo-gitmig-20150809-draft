# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.5-r2.ebuild,v 1.1 2002/09/12 22:40:24 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A modular textUI IRC client with IPv6 support."
SRC_URI="http://irssi.org/files/${P}.tar.bz2"
HOMEPAGE="http://irssi.org"

DEPEND="
	=dev-libs/glib-1.2*
	sys-libs/ncurses
	perl? ( sys-devel/perl )" 
	#socks? ( >=net-misc/dante-1.1.13 )

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"


src_compile() {

	# Note: there is an option to build a GUI for irssi, but according
	# to the website the GUI is no longer developed, so that option is
	# not used here.
	
	# Edit these if you like
	myconf="--without-servertest --with-bot --with-proxy --with-ncurses"
	
	use nls || myconf="${myconf} --disable-nls"

	#perl is auto-detected and must be explicitly disabled
	use perl || myconf="${myconf} --with-perl=no"

	#ipv6 needs to be explicitly enabled
	use ipv6 && myconf="${myconf} --enable-ipv6"

	#socks needs to be explicitly enabled
	#use socks && myconf="${myconf} --with-socks"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		${myconf} || die "./configure failed"

	emake || die
}

src_install () {
	myflags=""

	use perl && ( \
		cd ${S}/src/perl/common
		mv Makefile Makefile.orig
		sed "s:^PREFIX:PREFIX = ${D}/usr:" \
			Makefile.orig > Makefile
		cd ${S}
	)

	make DESTDIR=${D} \
		PREFIX=${D}/usr \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir=${D}/usr/share/locale \
		${myflags} \
		install || die

	dodoc AUTHORS ChangeLog README TODO NEWS
}

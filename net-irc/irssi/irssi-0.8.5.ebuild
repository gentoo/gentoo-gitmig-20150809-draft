# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi/irssi-0.8.5.ebuild,v 1.3 2002/07/17 07:36:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A modular textUI IRC client with IPv6 support."
SRC_URI="http://irssi.org/files/${P}.tar.bz2"
HOMEPAGE="http://irssi.org"

DEPEND="virtual/glibc
	=dev-libs/glib-1.2*
	sys-libs/ncurses
	perl? ( sys-devel/perl )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	# Note: there is an option to build a GUI for irssi, but according
	# to the website the gui is no longer developed, so that option is
	# not used here.
	
	# Edit these if you like
	myconf="--without-servertest --with-bot --with-proxy --with-ncurses"
	
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
	fi
	if [ "`use perl`" ]
	then
		myconf="${myconf} --enable-perl=yes"
	fi
	if [ "`use ipv6`" ]
	then
		myconf="${myconf} --enable-ipv6"
	fi

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
	if [ "`use perl`" ]
	then
		R1="s/installsitearch='//"
		R2="s/';//"
		perl_sitearch="`perl -V:installsitearch | sed -e ${R1} -e ${R2}`"
		myflags="${myflags} INSTALLPRIVLIB=${D}/usr"
		myflags="${myflags} INSTALLARCHLIB=${D}/${perl_sitearch}"
		myflags="${myflags} INSTALLSITELIB=${D}/${perl_sitearch}"
		myflags="${myflags} INSTALLSITEARCH=${D}/${perl_sitearch}"
	fi

	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		gnulocaledir=${D}/usr/share/locale \
		${myflags} \
		install || die

	dodoc AUTHORS ChangeLog README TODO NEWS
}

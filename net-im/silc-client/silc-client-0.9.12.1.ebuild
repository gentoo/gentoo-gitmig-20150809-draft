# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-client/silc-client-0.9.12.1.ebuild,v 1.1 2003/04/22 08:07:37 absinthe Exp $

DESCRIPTION="IRSSI-based text client for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/client/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="ipv6 perl socks5"

DEPEND="=dev-libs/glib-1.2*
	perl? ( dev-lang/perl )
	socks5? ( net-misc/dante )
	sys-libs/ncurses"

src_compile() {
	local myconf
	use ipv6 && myconf="${myconf} --enable-ipv6"
	use socks5 && myconf="${myconf} --with-socks5"
	
	econf \
		--prefix=/usr \
		--datadir=/usr/share/${PN} \
		--with-datadir=/usr/share/${PN} \
		--with-docdir=/usr/share/doc/${PN} \
		--with-helpdir=/usr/share/${PN}/help \
		--with-logsdir=/var/log/${PN} \
		--with-simdir=/usr/lib/${PN} \
		--with-ncurses \
		--without-silcd
		${myconf} \
		|| die "./configure failed"

	make || die "make failed"
}

src_install() {
	myflags=""
	if [ "`use perl`" ]
	then
		R1="s/installsitearch='//"
		R2="s/';//"
		perl_sitearch="`perl -V:installsitearch | sed -e ${R1} -e ${R2}`"
		myflags="${myflags} INSTALLPRIVLIB=${D}/usr/lib"
		myflags="${myflags} INSTALLARCHLIB=${D}/${perl_sitearch}"
		myflags="${myflags} INSTALLSITELIB=${D}/${perl_sitearch}"
		myflags="${myflags} INSTALLSITEARCH=${D}/${perl_sitearch}"
	fi

	make DESTDIR=${D} ${myflags} install || die "make install failed"
	mv ${D}/usr/libsilc.a ${D}/usr/lib/
	mv ${D}/usr/libsilcclient.a ${D}/usr/lib/
	mv ${D}/usr/libsilcclient.la ${D}/usr/lib/
	mv ${D}/usr/libsilc.la ${D}/usr/lib/
	rmdir ${D}/usr/share/silc/
	rmdir ${D}/usr/include
}

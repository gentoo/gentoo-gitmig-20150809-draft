# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-client/silc-client-0.9.11.ebuild,v 1.6 2003/04/24 22:31:18 liquidx Exp $

inherit libtool

DESCRIPTION="IRSSI-based text client for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/client/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="ipv6 perl ncurses"

DEPEND="=dev-libs/glib-1.2*
	perl? ( dev-lang/perl )
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	elibtoolize

	econf \
		--mandir=/usr/share/man \
		--with-helpdir=/usr/share/silc/help \
		--with-docdir=/usr/share/doc/${P} \
		--with-simdir=/usr/lib/silc/modules \
		--with-logsdir=/var/log/silc \
		--with-etcdir=/etc/silv \
		--with-libdir=/usr/lib \
		--without-libtoolfix \
		`use_with ncurses` \
		`use_with ipv6` \
		|| die "./configure failed"

	make || die "make failed"
}

src_install() {
	local myflags
	
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
	
	myflags="${myflags} mandir=${D}/usr/share/man"

	make DESTDIR=${D} ${myflags} install || die "make install failed"

	# screwed up libtool installs things in the wrong place
	mv ${D}/usr/libsilc* ${D}/usr/lib

	rmdir ${D}/usr/include
}

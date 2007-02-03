# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-client/silc-client-1.0.3.ebuild,v 1.5 2007/02/03 17:32:36 blubb Exp $

inherit eutils multilib

DESCRIPTION="IRSSI-based text client for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/client/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="ipv6 perl debug"

DEPEND="=dev-libs/glib-1.2*
	perl? (	dev-lang/perl )
	sys-libs/ncurses
	!<=net-im/silc-toolkit-0.9.12-r1
	sys-devel/autoconf-archive"
RDEPEND="${DEPEND}
	perl? (
		!net-irc/irssi
		!net-irc/irssi-svn
	)"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s:-g -O2:${CFLAGS}:g" configure
	epatch "${FILESDIR}/${P}-docdir.patch"
}

src_compile() {
	econf \
		--datadir=/usr/share \
		--with-datadir=/usr/share/${PN} \
		--with-simdir=/usr/$(get_libdir)/${PN} \
		--with-ncurses \
		--without-silcd \
		$(use_enable ipv6) \
		$(use_enable debug) \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	local myflags=""

	if use perl
	then
		R1="s/installsitearch='//"
		R2="s/';//"
		perl_sitearch="`perl -V:installsitearch | sed -e ${R1} -e ${R2}`"
		myflags="${myflags} INSTALLPRIVLIB=/usr/$(get_libdir)"
		myflags="${myflags} INSTALLARCHLIB=${perl_sitearch}"
		myflags="${myflags} INSTALLSITELIB=${perl_sitearch}"
		myflags="${myflags} INSTALLSITEARCH=${perl_sitearch}"
	fi

	make DESTDIR=${D} ${myflags} install || die "make install failed"

	rm -rf ${D}/etc ${D}/usr/libsilc* ${D}/usr/include

	dodoc CHANGES CREDITS README TODO
	cd "${S}/apps/irssi"
	dodoc silc.conf docs/formats.txt docs/manual.txt docs/signals.txt docs/special_vars.txt
	dohtml docs/startup-HOWTO.html

	insinto /usr/share/silc-client/help
	rm docs/help/Make*
	doins docs/help/*
}

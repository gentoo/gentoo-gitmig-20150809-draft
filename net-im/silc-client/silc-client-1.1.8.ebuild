# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-client/silc-client-1.1.8.ebuild,v 1.9 2012/05/04 06:22:11 jdhore Exp $

EAPI=2

inherit eutils multilib

DESCRIPTION="IRSSI-based text client for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/client/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="ipv6 perl debug"

COMMONDEPEND="perl? ( dev-lang/perl )
	sys-libs/ncurses
	>=dev-libs/glib-2.8
	!<=net-im/silc-toolkit-0.9.12-r1"

DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	>=net-im/silc-toolkit-1.1.10"

RDEPEND="${COMMONDEPEND}
	perl? (
		!net-irc/irssi
		!net-irc/irssi-svn
	)"

src_prepare() {
	sed -i -e "s:-g -O2:${CFLAGS}:g" configure
	use amd64 && sed -i -e 's:felf\([^6]\):felf64\1:g' configure
	epatch "${FILESDIR}/${PN}-1.1.8-docdir.patch"
	epatch "${FILESDIR}/${P}-sandbox-errors-fix.patch"
}

src_configure() {
	econf \
		--datadir=/usr/share/${PN} \
		--datarootdir=/usr/share/${PN} \
		--mandir=/usr/share/man \
		--includedir=/usr/include/${PN} \
		--sysconfdir=/etc/silc \
		--with-helpdir=/usr/share/${PN}/help \
		--libdir=/usr/$(get_libdir)/${PN} \
		--docdir=/usr/share/doc/${PF} \
		--disable-optimizations \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with perl)
}

src_install() {
	local myflags=""

	if use perl
	then
		perl_sitearch="`perl -V:installsitearch | sed "s|.*'\(.*\)'.*|\1|"`"
		myflags="INSTALLPRIVLIB=/usr/$(get_libdir)"
		myflags+=" INSTALLARCHLIB=${perl_sitearch}"
		myflags+=" INSTALLSITELIB=${perl_sitearch}"
		myflags+=" INSTALLSITEARCH=${perl_sitearch}"
	fi

	emake DESTDIR="${D}" ${myflags} install || die "make install failed"

	rm -rf "${D}"/etc

	dodoc ChangeLog CREDITS README TODO || die
	cd "${S}/apps/irssi" || die
	dodoc silc.conf docs/formats.txt docs/manual.txt docs/signals.txt docs/special_vars.txt || die
	dohtml docs/startup-HOWTO.html || die

	insinto /usr/share/silc-client/help
	rm docs/help/Make* || die
	doins docs/help/* || die
}

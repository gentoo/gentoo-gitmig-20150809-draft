# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-3.4.6.ebuild,v 1.1 2006/04/25 22:24:49 dragonheart Exp $

DESCRIPTION="A sophisticated ftp/http client, file transfer program"
HOMEPAGE="http://lftp.yar.ru/"

#SRC_URI="http://the.wiretapped.net/mirrors/lftp/${P}.tar.bz2"
# Was a bit too slow and unreliable last time I tried (dragonheart)
SRC_URI="ftp://lftp.yar.ru/lftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="ssl gnutls socks5 nls"

RDEPEND=">=sys-libs/ncurses-5.1
		socks5? ( >=net-proxy/dante-1.1.12 )
		socks5? ( virtual/pam )
		ssl? (
			gnutls? ( >=net-libs/gnutls-1.2.3 )
			!gnutls? ( >=dev-libs/openssl-0.9.6 )
		)
		virtual/libc
		!ppc-macos? ( >=sys-libs/readline-5.1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-lang/perl
	>=sys-apps/sed-4
	sys-apps/gawk
	sys-devel/bison
	sys-devel/libtool"

src_compile() {
	local myconf="$(use_enable nls)"

	if use ssl && use gnutls ; then
		myconf="${myconf} --without-openssl"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf} --without-gnutls --with-openssl=/usr"
	else
		myconf="${myconf} --without-gnutls --without-openssl"
	fi

	use socks5 && myconf="${myconf} --with-socksdante=/usr" \
		|| myconf="${myconf} --without-socksdante"

	use ppc-macos && myconf="${myconf} --with-included-readline"
	econf \
		--sysconfdir=/etc/lftp \
		--without-modules \
		${myconf} || die "econf failed"

	emake || die "compile problem"
}

src_install() {
	emake install DESTDIR=${D} || die

	# hrmph, empty..
	rm -rf ${D}/usr/lib

	dodoc BUGS ChangeLog FAQ FEATURES MIRRORS \
		NEWS README* THANKS TODO
}

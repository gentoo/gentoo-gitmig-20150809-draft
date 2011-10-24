# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-4.3.3.ebuild,v 1.1 2011/10/24 11:25:26 jer Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="A sophisticated ftp/sftp/http/https/torrent client and file transfer program"
HOMEPAGE="http://lftp.yar.ru/"
SRC_URI="http://ftp.yars.free.net/pub/source/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="ssl gnutls socks5 nls"

RDEPEND="
	>=sys-libs/ncurses-5.1
	socks5? (
		>=net-proxy/dante-1.1.12
		virtual/pam )
	ssl? (
		gnutls? ( >=net-libs/gnutls-1.2.3 )
		!gnutls? ( >=dev-libs/openssl-0.9.6 )
	)
	>=sys-libs/readline-5.1
"

DEPEND="
	${RDEPEND}
	=sys-devel/libtool-2*
	app-arch/xz-utils
	dev-lang/perl
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
"
src_prepare() {
	epatch "${FILESDIR}/${PN}-4.0.2.91-lafile.patch"
	epatch "${FILESDIR}/${PN}-4.0.3-autoconf-2.64.patch"
	eautoreconf
}

src_configure() {
	local myconf="$(use_enable nls) --enable-packager-mode"

	if use ssl && use gnutls ; then
		myconf="${myconf} --without-openssl"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf} --without-gnutls --with-openssl=/usr"
	else
		myconf="${myconf} --without-gnutls --without-openssl"
	fi

	use socks5 && myconf="${myconf} --with-socksdante=/usr" \
		|| myconf="${myconf} --without-socksdante"

	econf \
		--sysconfdir=/etc/lftp \
		--with-modules \
		${myconf} || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die

	dodoc BUGS ChangeLog FAQ FEATURES MIRRORS \
			NEWS README* THANKS TODO
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-3.99.9.ebuild,v 1.1 2009/08/10 15:56:36 jer Exp $

EAPI="2"

DESCRIPTION="A sophisticated ftp/sftp/http/https client and file transfer program"
HOMEPAGE="http://lftp.yar.ru/"
SRC_URI="ftp://ftp.yar.ru/lftp/devel/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="ssl gnutls socks5 nls"

RDEPEND=">=sys-libs/ncurses-5.1
		socks5? (
			>=net-proxy/dante-1.1.12
			virtual/pam )
		ssl? (
			gnutls? ( >=net-libs/gnutls-1.2.3 )
			!gnutls? ( >=dev-libs/openssl-0.9.6 )
		)
		virtual/libc
		>=sys-libs/readline-5.1"

DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-lang/perl
	=sys-devel/libtool-2*
"

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

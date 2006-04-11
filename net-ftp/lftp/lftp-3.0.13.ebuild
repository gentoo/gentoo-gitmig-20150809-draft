# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-3.0.13.ebuild,v 1.15 2006/04/11 21:39:11 dragonheart Exp $

inherit eutils

DESCRIPTION="A sophisticated ftp/http client, file transfer program"
HOMEPAGE="http://lftp.yar.ru/"

SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE="ssl socks5 nls"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	!ppc-macos? (
		socks5? ( >=net-proxy/dante-1.1.12
			sys-libs/pam )
	)
	nls? ( sys-devel/gettext )
	alpha? ( dev-lang/perl )
	alpha? ( >=sys-apps/sed-4 )
	virtual/libc
	!ppc-macos? ( sys-libs/readline )
	sys-apps/gawk
	sys-devel/bison
	sys-devel/libtool"

RDEPEND="
	>=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	virtual/libc
	sys-libs/readline
	!ppc-macos? ( socks5? ( sys-libs/pam >=net-proxy/dante-1.1.12 ) )"

src_compile() {
	local myconf="`use_enable nls`"

	use ssl && myconf="${myconf} --with-ssl=/usr" \
		|| myconf="${myconf} --without-ssl"

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

	dodoc BUGS COPYING ChangeLog FAQ FEATURES MIRRORS \
		NEWS README* THANKS TODO
}

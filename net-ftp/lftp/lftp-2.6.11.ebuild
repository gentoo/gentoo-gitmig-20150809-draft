# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-2.6.11.ebuild,v 1.1 2003/12/26 01:23:22 pyrania Exp $

IUSE="ssl socks5 nls"

inherit eutils

DESCRIPTION="A sophisticated ftp/http client, file transfer program."
HOMEPAGE="http://ftp.yars.free.net/projects/lftp/"
SRC_URI="http://ftp.yars.free.net/pub/software/unix/net/ftp/client/lftp/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	socks5? ( >=net-misc/dante-1.1.12 )
	nls? ( sys-devel/gettext )
	alpha? ( dev-lang/perl )
	alpha? ( >=sys-apps/sed-4 )"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls && myconf="--enable-nls" \
		|| myconf="--disable-nls"

	use ssl && myconf="${myconf} --with-ssl=/usr" \
		|| myconf="${myconf} --without-ssl"

	use socks5 && myconf="${myconf} --with-socksdante=/usr" \
		|| myconf="${myconf} --without-socksdante"

	econf \
		--sysconfdir=/etc/lftp \
		--without-modules \
		${myconf}

	make || die "compile problem"
}

src_install() {
	make install DESTDIR=${D} || die

	# hrmph, empty..
	rm -rf ${D}/usr/lib

	dodoc BUGS COPYING ChangeLog FAQ FEATURES MIRRORS \
		NEWS README* THANKS TODO
}

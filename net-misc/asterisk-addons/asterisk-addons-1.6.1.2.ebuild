# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-addons/asterisk-addons-1.6.1.2.ebuild,v 1.2 2010/02/19 15:48:12 chainsaw Exp $

inherit eutils

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.digium.com/pub/asterisk/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="bluetooth elibc_uclibc mysql"

RDEPEND="=net-misc/asterisk-1.6.1*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-parallel-make.diff"

	# forward-ported patch from jaervosz for uclibc
	if use elibc_uclibc; then
		epatch "${FILESDIR}/${P}-uclibc.diff"
	fi
}

src_compile() {
	econf \
		--libdir="/usr/$(get_libdir)" \
		--localstatedir="/var" \
		$(use_with bluetooth) \
		$(use_with mysql mysqlclient) \
		|| die "Failed to configure"

	emake || die "Failed to compile"
}

src_install() {
	dodoc configs/*
	emake DESTDIR="${D}" install || die "Failed to install"
}

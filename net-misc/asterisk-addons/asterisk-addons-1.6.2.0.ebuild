# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-addons/asterisk-addons-1.6.2.0.ebuild,v 1.1 2010/02/19 15:48:12 chainsaw Exp $

EAPI=2
inherit eutils

DESCRIPTION="Asterisk: A Modular Open Source PBX System"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.digium.com/pub/asterisk/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="bluetooth elibc_uclibc h323 mysql"

RDEPEND=">=net-misc/asterisk-1.6.2.0"

src_prepare() {
	epatch "${FILESDIR}/${P}-parallel-make.diff"
	epatch "${FILESDIR}/${P}-respect-destdir.diff"

	# forward-ported patch from jaervosz for uclibc
	if use elibc_uclibc; then
		epatch "${FILESDIR}/${P}-uclibc.diff"
	fi

	if ! use bluetooth; then
		rm "${S}/doc/chan_mobile.txt"
		rm "${S}/channels/chan_mobile.c"
		rm "${S}/configs/mobile.conf.sample"
	fi
	if ! use h323; then
		rm "${S}/doc/ChangeLog.chan_ooh323"
		rm "${S}/doc/chan_ooh323.txt"
		rm "${S}/channels/chan_ooh323.c"
		rm -rf "${S}/channels/ooh323c"
		rm "${S}/channels/chan_ooh323.h"
		rm "${S}/channels/ooh323cDriver.c"
		rm "${S}/configs/ooh323.conf.sample"
	fi
}

src_configure() {
	econf \
		--libdir="/usr/$(get_libdir)" \
		--localstatedir="/var" \
		$(use_with mysql mysqlclient) \
		|| die "Failed to configure"
}

src_install() {
	dodoc configs/*
	mkdir "${D}/var/lib/asterisk/documentation"
	emake DESTDIR="${D}" install || die "Failed to install"
}

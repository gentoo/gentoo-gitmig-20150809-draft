# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimxcf/iiimxcf-11.4.1467.ebuild,v 1.1 2003/09/14 00:41:21 usata Exp $

inherit iiimf

DESCRIPTION="IIIMXCF is an X client framework for IIIMF"

KEYWORDS="~x86"

DEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf"

src_unpack() {

	unpack ${A}
	cd ${S}/xiiimp.so
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	cd ${S}/xiiimp.so
	iiimf_src_compile || die
	cd ${S}/htt_xbe
	iiimf_src_compile || die
}

src_install() {

	cd ${S}/xiiimp.so
	make DESTDIR=${D} install || die
	docinto xiiimp.so
	dodoc AUTHORS NEWS README ChangeLog COPYING

	cd ${S}/htt_xbe
	make DESTDIR=${D} install || die
	docinto htt_xbe
	dodoc ChangeLog
}

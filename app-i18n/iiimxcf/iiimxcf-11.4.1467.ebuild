# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimxcf/iiimxcf-11.4.1467.ebuild,v 1.4 2004/06/14 07:19:20 kloeri Exp $

inherit iiimf eutils

DESCRIPTION="X client framework for IIIMF"

KEYWORDS="~x86 -alpha"
IUSE=""

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
	dodoc AUTHORS NEWS README ChangeLog

	cd ${S}/htt_xbe
	make DESTDIR=${D} install || die
	docinto htt_xbe
	dodoc ChangeLog
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimxcf/iiimxcf-11.4_p1467.ebuild,v 1.1 2004/09/13 19:59:51 usata Exp $

inherit iiimf eutils

DESCRIPTION="X client framework for IIIMF"

KEYWORDS="x86 -alpha"
IUSE=""

RDEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/xiiimp.so/iiimp
	sed -i -e 's,$(IM_LIBDIR)/iiimcf,/usr/lib,g' \
		-e 's,$(IM_LIBDIR)/iiimp,/usr/lib,g' \
		Makefile.am || die "sed Makefile.am failed."
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

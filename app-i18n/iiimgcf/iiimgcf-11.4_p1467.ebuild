# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimgcf/iiimgcf-11.4_p1467.ebuild,v 1.1 2004/09/13 20:02:11 usata Exp $

inherit iiimf eutils

DESCRIPTION="IIIMGCF is a GTK+ client framework for IIIMF"

LICENSE="LGPL-2.1"
KEYWORDS="x86"
IUSE="gtk"

RDEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf
	gtk? ( =x11-libs/gtk+-2* )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's,$(IM_LIBDIR)/iiimcf,/usr/lib,g' \
		-e 's,$(IM_LIBDIR)/iiimp,/usr/lib,g' \
		Makefile.* || die "sed failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimgcf/iiimgcf-12.1_p2002.ebuild,v 1.1 2005/03/30 17:10:11 usata Exp $

inherit iiimf eutils

DESCRIPTION="IIIMGCF is a GTK+ client framework for IIIMF"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~x86"
IUSE="gtk"

RDEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf
	gtk? ( =x11-libs/gtk+-2* )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/autoconf
	sys-devel/automake"

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

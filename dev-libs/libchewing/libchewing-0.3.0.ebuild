# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.3.0.ebuild,v 1.1 2006/11/05 15:43:52 usata Exp $

inherit eutils

IUSE=""
DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="http://chewing.csie.net/download/libchewing/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	if [[ -e "${ROOT}"/usr/$(get_libdir)/libchewing.so.1 ]] ; then
		ewarn "You must re-compile all packages that are linked against"
		ewarn "<libchewing-0.2.7 by using revdep-rebuild from gentoolkit:"
		ewarn "# revdep-rebuild --library libchewing.so.1"
	fi

	if [[ -e "${ROOT}"/usr/$(get_libdir)/libchewing.so.2 ]] ; then
		ewarn "You must re-compile all packages that are linked against"
		ewarn "<libchewing-0.3.0 by using revdep-rebuild from gentoolkit:"
		ewarn "# revdep-rebuild --library libchewing.so.2"
	fi
}

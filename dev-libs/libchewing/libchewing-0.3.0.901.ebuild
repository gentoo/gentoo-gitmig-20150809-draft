# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.3.0.901.ebuild,v 1.1 2008/09/20 16:18:42 matsuu Exp $

inherit multilib

DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="http://chewing.csie.net/download/rc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug test"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	test? ( >=dev-libs/check-0.8.2 )"

src_compile() {
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	if [[ -e "${ROOT}"/usr/$(get_libdir)/libchewing.so.1 ]] ; then
		elog "You must re-compile all packages that are linked against"
		elog "<libchewing-0.2.7 by using revdep-rebuild from gentoolkit:"
		elog "# revdep-rebuild --library libchewing.so.1"
	fi

	if [[ -e "${ROOT}"/usr/$(get_libdir)/libchewing.so.2 ]] ; then
		elog "You must re-compile all packages that are linked against"
		elog "<libchewing-0.3.0 by using revdep-rebuild from gentoolkit:"
		elog "# revdep-rebuild --library libchewing.so.2"
	fi
}

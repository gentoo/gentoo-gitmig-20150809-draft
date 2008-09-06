# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.3.0-r1.ebuild,v 1.1 2008/09/06 03:46:31 matsuu Exp $

inherit eutils multilib

IUSE=""
DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="http://chewing.csie.net/download/libchewing/${P}.tar.gz
	http://gentoo-china-overlay.googlecode.com/svn/distfiles/${P}-fc9-patches.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND="virtual/libc"

src_unpack() {
	unpack "${P}".tar.gz
	#patches from federa core
	epatch "${DISTDIR}/${P}"-fc9-patches.tar.bz2
}

src_install() {
	emake DESTDIR="${D}" install || die

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

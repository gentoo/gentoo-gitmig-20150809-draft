# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-fep/uim-fep-0.4.0.ebuild,v 1.1 2004/08/03 19:15:49 usata Exp $

IUSE="unicode"

DESCRIPTION="UIM multilingual input method frontend processor for console"
HOMEPAGE="http://www.ice.nuie.nagoya-u.ac.jp/~h013177b/uim-fep/"
SRC_URI="http://www.ice.nuie.nagoya-u.ac.jp/~h013177b/uim-fep/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=app-i18n/uim-0.3.4.2
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	!>=app-i18n/uim-0.4.0
	!app-i18n/uim-svn"

src_compile() {

	local myconf
	if use unicode ; then
		myconf="${myconf} --with-enc=utf-8"
	else
		myconf="${myconf} --with-enc=euc-jp"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc README COPYING INSTALL
}

pkg_postinst() {

	einfo
	einfo "uim-fep is configured for skk. If you want to change it, you can set"
	einfo "UIM_FEP environment variable to one of skk, prime, anthy, canna,"
	einfo "tcode and tutcode or run uim-fep with -u option with engines listed above."
	einfo
}

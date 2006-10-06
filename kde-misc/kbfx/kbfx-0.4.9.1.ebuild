# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbfx/kbfx-0.4.9.1.ebuild,v 1.6 2006/10/06 18:48:19 deathwing00 Exp $

inherit kde

WANT_AUTOMAKE="1.6"
WANT_AUTOCONF="2.1"

DESCRIPTION="KDE alternative K-Menu"
HOMEPAGE="http://www.kbfx.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:\$(LIB_KIO):-L${KDEDIR}/lib -lkio:" kbfxconfigapp/Makefile.am
	#rm -rf "${S}/configure"
	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
}

src_install() {
	kde_src_install
	rm -rf "${D}/crystalsvg"
}

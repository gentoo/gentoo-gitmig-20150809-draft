# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doc++/doc++-3.4.10-r4.ebuild,v 1.1 2012/01/29 02:43:43 xmw Exp $

EAPI=4

inherit eutils

DESCRIPTION="Documentation system for C, C++, IDL and Java"
HOMEPAGE="http://docpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/docpp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-flex.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i -e "s/locale.alias//g" "${S}"/intl/Makefile.in || die
	sed -r "/^ac_compile=/s:\\\$CFLAGS:$CFLAGS:" -i "${S}"/configure || die
	sed -r "/^ac_compile=/s:\\\$CXXFLAGS:$CXXFLAGS:" -i "${S}"/configure || die
}

src_compile() {
	emake all
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc CREDITS INSTALL NEWS PLATFORMS REPORTING-BUGS

	#Install Latex style file
	insinto /usr/share/${PN}
	doins doc/*.sty
}

pkg_postinst() {
	einfo "                                                "
	einfo "The latex style files for doc++ may be found in "
	einfo "/usr/share/doc++                                "
	einfo "                                                "
}

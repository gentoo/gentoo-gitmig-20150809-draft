# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doc++/doc++-3.4.10-r3.ebuild,v 1.2 2008/06/28 23:16:12 loki_val Exp $

inherit eutils

DESCRIPTION="Documentation system for C, C++, IDL and Java"
HOMEPAGE="http://docpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/docpp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-flex.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i -e "s/locale.alias//g" "${S}"/intl/Makefile.in
}

src_compile() {
	econf || die
	emake all || die
}

src_install() {
	make install DESTDIR="${D}" || die
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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chasen/chasen-2.3.2.ebuild,v 1.3 2004/04/25 15:00:25 usata Exp $

if [ `use perl` ] ; then
	inherit perl-module
fi

DESCRIPTION="Japanese Morphological Analysis System, ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/chasen/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="perl"

DEPEND="${DEPEND}
	>=dev-libs/darts-0.2"
PDEPEND=">=app-dicts/ipadic-2.6.1"

src_compile() {

	econf || die
	emake || die
	if [ `use perl` ] ; then
		cd ${S}/perl
		perl-module_src_compile
	fi
}

src_install () {
	einstall || die

	dodoc README* NEWS* COPYING AUTHORS ChangeLog || die
	dodoc doc/* || die

	if [ `use perl` ] ; then
		cd ${S}/perl
		perl-module_src_install
	fi
}

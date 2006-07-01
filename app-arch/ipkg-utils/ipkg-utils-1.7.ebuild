# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ipkg-utils/ipkg-utils-1.7.ebuild,v 1.6 2006/07/01 16:06:06 seemant Exp $

inherit distutils eutils toolchain-funcs

DESCRIPTION="Tools for working with the ipkg binary package format"
HOMEPAGE="http://www.openembedded.org/"
SRC_URI="http://handhelds.org/download/packages/ipkg-utils/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~x86"

DEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}; cd ${S}

	epatch ${FILESDIR}/${P}-build_fixes.patch
}

src_compile() {
	distutils_src_compile
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	distutils_src_install
	make DESTDIR=${D} install || die
}

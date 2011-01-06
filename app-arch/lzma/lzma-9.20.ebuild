# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzma/lzma-9.20.ebuild,v 1.1 2011/01/06 02:57:10 vapier Exp $

inherit toolchain-funcs

MY_P="${PN}${PV//.}"
DESCRIPTION="LZMA Stream Compressor from the SDK"
HOMEPAGE="http://www.7-zip.org/sdk.html"
SRC_URI="mirror://sourceforge/sevenzip/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc"

S=${WORKDIR}

src_compile() {
	cd CPP/7zip/Bundles/LzmaCon
	emake -f makefile.gcc \
		CXX="$(tc-getCXX) ${CXXFLAGS} ${CPPFLAGS}" \
		CXX_C="$(tc-getCC) ${CFLAGS} ${CPPFLAGS}" \
		|| die "Make failed"
}

src_install() {
	newbin CPP/7zip/Bundles/LzmaCon/lzma lzmacon || die
	dodoc lzma.txt history.txt
	use doc && dodoc 7zC.txt 7zFormat.txt Methods.txt
}

pkg_postinst() {
	einfo "The lzma binary is now 'lzmacon' to avoid xz-utils conflicts #218459"
}

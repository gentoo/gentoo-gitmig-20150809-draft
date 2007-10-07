# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzma/lzma-4.43.ebuild,v 1.4 2007/10/07 18:10:20 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="LZMA Stream Compressor from the SDK"
HOMEPAGE="http://www.7-zip.org/sdk.html"
SRC_URI="mirror://sourceforge/sevenzip/${PN}443.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc-macos ~x86"
IUSE="doc"

RDEPEND="!app-arch/lzma-utils"

S=${WORKDIR}

src_compile() {
	cd C/7zip/Compress/LZMA_Alone
	emake -f makefile.gcc \
		CXX="$(tc-getCXX) ${CXXFLAGS}" \
		CXX_C="$(tc-getCC) ${CFLAGS}" \
		|| die "Make failed"
}

src_install() {
	dobin C/7zip/Compress/LZMA_Alone/lzma || die
	dodoc history.txt
	use doc && dodoc 7zC.txt 7zFormat.txt lzma.txt Methods.txt
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/excelformat/excelformat-100112.ebuild,v 1.2 2010/06/30 13:50:54 jlec Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Library for reading, writing, and editing of XLS (BIFF8 format) files"
HOMEPAGE="http://www.codeproject.com/KB/office/ExcelFormat.aspx"
SRC_URI="mirror://gentoo/${P}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="CPOL"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
app-arch/unzip"

S="${WORKDIR}"

src_prepare() {
	edos2unix *
	epatch "${FILESDIR}"/${PV}-gcc.patch
}

src_compile() {
	local cmd
	for i in *.cpp; do
		cmd="$(tc-getCXX) ${CXXFLAGS} -trigraphs -c $i"
		einfo ${cmd}
		${cmd} || die
	done
	cmd="$(tc-getCXX) ${LDFLAGS} -Wl,-soname,libExcelFormat.so.0 -o libExcelFormat.so.0.0.0 `ls *.o`"
	einfo ${cmd}
	${cmd} || die
	cmd="$(tc-getAR) cru libExcelFormat.a `ls *.o`"
	einfo ${cmd}
	${cmd} || die
	cmd="$(tc-getRANLIB) libExcelFormat.a"
	einfo ${cmd}
	${cmd} || die
}

src_install() {
	insinto /usr/include/
	doins BasicExcel.hpp ExcelFormat.h || die
	dolib.so libExcelFormat.so.0.0.0 || die
	dosym libExcelFormat.so.0.0.0 /usr/$(get_libdir)/libExcelFormat.so || die
	dolib.a libExcelFormat.a || die
}

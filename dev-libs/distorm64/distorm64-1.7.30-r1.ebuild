# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/distorm64/distorm64-1.7.30-r1.ebuild,v 1.2 2009/06/29 12:29:20 arfrever Exp $

EAPI="2"

inherit eutils flag-o-matic python toolchain-funcs

DESCRIPTION="The ultimate disassembler library (X86-32, X86-64)"
HOMEPAGE="http://www.ragestorm.net/distorm/"
SRC_URI="http://ragestorm.net/distorm/${PN}-pkg${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+python"

DEPEND="python? ( >=dev-lang/python-2.4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-python.patch"
	epatch "${FILESDIR}/${P}-respect_flags.patch"
}

src_compile() {
	cd "${WORKDIR}/${PN}/build/linux"
	emake clib CC="$(tc-getCC)" || die "make clib failed!"

	if use python; then
		python_version
		append-flags "-I/usr/include/python${PYVER}"
		emake py CC="$(tc-getCC)" || die "make py failed!"
	fi

	cd "${WORKDIR}/${PN}/linuxproj"
	emake disasm CC="$(tc-getCC)" || die "make disasm failed!"

}

src_install() {
	cd "${WORKDIR}/${PN}/build/linux"

	dolib.so libdistorm64.so

	if use python; then
		dodir "$(python_get_sitedir)"
		install libdistorm64.so "${D}$(python_get_sitedir)/distorm.so"
	fi

	cd "${WORKDIR}/${PN}/"
	newlib.a distorm64.a libdistorm64.a

	dobin linuxproj/disasm

	dodir "/usr/include"
	install distorm.h "${D}usr/include/" || die "Unable to install distorm.h"
}

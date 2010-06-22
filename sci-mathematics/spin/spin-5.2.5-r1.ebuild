# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/spin/spin-5.2.5-r1.ebuild,v 1.1 2010/06/22 17:49:59 phajdan.jr Exp $

EAPI="2"

inherit eutils versionator

MY_PV=$(replace_all_version_separators '')
MY_P="${PN}${MY_PV}"

DESCRIPTION="Tool for formal verification of distributed software systems."
HOMEPAGE="http://spinroot.com/"
SRC_URI="http://spinroot.com/spin/Src/${MY_P}.tar.gz
	http://spinroot.com/spin/Src/xspin525.tcl"

LICENSE="|| ( spin-commercial spin-educational )"
SLOT="0"
KEYWORDS="~x86"
IUSE="graphviz tk"

DEPEND="sys-devel/bison"
RDEPEND="sys-devel/gcc
	sys-process/time
	tk? (
		dev-lang/tk
		graphviz? ( media-gfx/graphviz )
	)"

S="${WORKDIR}/Spin/Src${PV}"

src_unpack() {
	unpack "${MY_P}.tar.gz"
	cp "${DISTDIR}/xspin525.tcl" "${S}/xspin.tcl" || die "cp failed"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-makefile.patch"
	epatch "${FILESDIR}/${PN}-xspin-r1.patch"
	epatch "${FILESDIR}/${PN}-font-size.patch"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dobin spin || die "dobin failed"
	doman ../Man/spin.1 || die "doman failed"
	dodoc ../Doc/* || die "dodoc failed"
	if use tk; then
		newbin xspin.tcl xspin || die "newbin failed"
		make_desktop_entry xspin XSpin
	fi
}

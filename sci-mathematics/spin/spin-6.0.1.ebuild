# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/spin/spin-6.0.1.ebuild,v 1.2 2011/01/05 00:04:13 hwoarang Exp $

EAPI="2"

inherit eutils versionator

MY_PV=$(replace_all_version_separators '')
MY_P="${PN}${MY_PV}"

DESCRIPTION="Tool for formal verification of distributed software systems."
HOMEPAGE="http://spinroot.com/"
SRC_URI="http://spinroot.com/spin/Src/${MY_P}.tar.gz"

LICENSE="|| ( spin-commercial spin-educational )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz tk"

DEPEND="sys-devel/bison"
RDEPEND="sys-devel/gcc
	sys-process/time
	tk? (
		dev-lang/tk
		graphviz? ( media-gfx/graphviz )
	)"

S="${WORKDIR}/Spin/Src${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-6.0.1-makefile.patch"
}

src_compile() {
	emake -j1 || die
}

src_install() {
	dobin spin || die
	doman ../Man/spin.1 || die
	dodoc ../Doc/* || die
	if use tk; then
		newbin "${WORKDIR}/Spin/iSpin/ispin.tcl" ispin || die
		make_desktop_entry ispin
	fi
}

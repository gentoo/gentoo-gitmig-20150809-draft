# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gamer/gamer-1.4.ebuild,v 1.1 2010/11/01 14:30:16 jlec Exp $

EAPI="3"

inherit autotools eutils multilib

DESCRIPTION="Geometry-preserving Adaptive MeshER"
HOMEPAGE="http://fetk.org/codes/gamer/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-libs/maloc"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-multilib.patch
	eautoreconf
}

src_configure() {
	local fetk_include
	local fetk_lib

	fetk_include="${EPREFIX}"/usr/include
	fetk_lib="${EPREFIX}"/usr/$(get_libdir)
	export FETK_INCLUDE="${fetk_include}"
	export FETK_LIBRARY="${fetk_lib}"

	econf \
		--disable-triplet \
		--enable-shared
}

src_install() {
	emake DESTDIR="${D}" install || die
}

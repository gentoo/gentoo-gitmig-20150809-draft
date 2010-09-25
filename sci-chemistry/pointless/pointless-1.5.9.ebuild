# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pointless/pointless-1.5.9.ebuild,v 1.3 2010/09/25 08:59:18 jlec Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Scores crystallographic Laue and space groups"
HOMEPAGE="ftp://ftp.mrc-lmb.cam.ac.uk/pub/pre/pointless.html"
SRC_URI="ftp://ftp.mrc-lmb.cam.ac.uk/pub/pre/${P}.tar.gz"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	sci-chemistry/ccp4-apps
	>=sci-libs/ccp4-libs-6.1.3
	<sci-libs/cctbx-2010.03.29.2334-r2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/1.5.1-gcc4.4.patch
}

src_compile() {
	emake  \
		-f Makefile.make \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		LFLAGS="${LDFLAGS}" \
		CLIB="${EPREFIX}/usr/$(get_libdir)" \
		CCTBX_sources="${EPREFIX}"/usr/$(get_libdir)/cctbx/cctbx_sources \
		CCTBX_VERSION=2009 \
		ICCP4=-I"${EPREFIX}"/usr/include/ccp4 \
		ICLPR="-I${EPREFIX}/usr/include -I${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_sources -I${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_build/include" \
		LTBX="-L${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_build/lib -lcctbx" \
		SLIB="$(gcc-config -L | awk -F: '{for(i=1; i<=NF; i++) printf " -L%s", $i}') -L${EPREFIX}/usr/$(get_libdir) -lgfortran -lgfortranbegin" \
		|| die
}

src_install() {
	dobin pointless othercell || die
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/amap/amap-2.2-r1.ebuild,v 1.2 2010/08/10 15:26:30 xarthisius Exp $

# Java is optional, don't force an ant dependency
JAVA_ANT_DISABLE_ANT_CORE_DEP="yes"

inherit eutils toolchain-funcs java-pkg-opt-2 java-ant-2

MY_P="${PN}.${PV}"
DESCRIPTION="Protein multiple-alignment-based sequence annealing"
HOMEPAGE="http://bio.math.berkeley.edu/amap/"
SRC_URI="http://baboon.math.berkeley.edu/amap/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="
	java? (
		>=virtual/jre-1.5
	)"
DEPEND="${RDEPEND}
	java? (
		>=dev-java/ant-core-1.7.0
		>=dev-java/javatoolkit-0.3.0-r2
		>=virtual/jdk-1.5
	)"
S="${WORKDIR}/${PN}-align"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cxxflags.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
	sed -i -e "s/\$(CXX)/& \$(LDFLAGS)/" "${S}"/align/Makefile || die #332009
}

src_compile() {
	pushd "${S}"/align
	emake \
		CXX="$(tc-getCXX)" \
		OPT_CXXFLAGS="${CXXFLAGS}" \
		|| die "make failed"
	popd

	if use java; then
		pushd "${S}"/display
		eant all || die
		popd
	fi
}

src_install() {
	dobin align/${PN}
	dodoc align/README align/PROBCONS.README
	insinto /usr/share/${PN}/examples
	doins examples/* || die "Failed to install examples"
	if use java; then
		java-pkg_newjar "${S}"/display/AmapDisplay.jar amapdisplay.jar
		java-pkg_dolauncher amapdisplay --jar amapdisplay.jar
	fi
}

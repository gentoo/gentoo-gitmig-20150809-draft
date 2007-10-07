# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/probcons/probcons-1.12.ebuild,v 1.2 2007/10/07 02:39:03 dberkholz Exp $

inherit eutils toolchain-funcs

MY_P="${PN}_v${PV/./_}"
DESCRIPTION="Probabilistic Consistency-based Multiple Alignment of Amino Acid Sequences"
HOMEPAGE="http://probcons.stanford.edu/"
SRC_URI="http://probcons.stanford.edu/${MY_P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# Gnuplot is explicitly runtime-only, it's run using system()
RDEPEND="sci-visualization/gnuplot"
DEPEND=""
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-cxxflags.patch
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		OPT_CXXFLAGS="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin probcons project makegnuplot || die "failed to install"
	# Overlap with imagemagick
	newbin compare compare-probcons || die "failed to install compare"
	dodoc README
}

pkg_postinst() {
	ewarn "The 'compare' binary is installed as 'compare-probcons'"
	ewarn "to avoid overlap with other packages."
	einfo "You may also want to download the user manual"
	einfo "from http://probcons.stanford.edu/manual.pdf"
}

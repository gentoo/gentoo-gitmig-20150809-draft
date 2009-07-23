# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jrtplib/jrtplib-3.7.1-r1.ebuild,v 1.1 2009/07/23 15:01:32 volkmar Exp $

EAPI="2"

inherit eutils

DESCRIPTION="JRTPLIB is an object-oriented RTP library written in C++."
HOMEPAGE="http://research.edm.luc.ac.be/jori/jrtplib/jrtplib.html"
SRC_URI="http://research.edm.luc.ac.be/jori/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples ipv6"

RDEPEND="dev-libs/jthread"
DEPEND="${RDEPEND}"

src_prepare() {
	# do not compile examples
	sed -i -e "s/examples //" Makefile.in || die "sed failed"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-gcc-4.4.patch
}

src_configure() {
	econf $(use_enable ipv6 IPv6)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README.TXT TODO || die "dodoc failed"

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins examples/*.cpp || die "doins failed"
	fi
}

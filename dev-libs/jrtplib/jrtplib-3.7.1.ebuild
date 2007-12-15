# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jrtplib/jrtplib-3.7.1.ebuild,v 1.1 2007/12/15 15:34:12 drac Exp $

DESCRIPTION="JRTPLIB is an object-oriented RTP library written in C++."
HOMEPAGE="http://research.edm.luc.ac.be/jori/jrtplib/jrtplib.html"
SRC_URI="http://research.edm.luc.ac.be/jori/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples ipv6"

RDEPEND="dev-libs/jthread"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable ipv6 IPv6)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README* TODO

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins examples/*.cpp
	fi
}

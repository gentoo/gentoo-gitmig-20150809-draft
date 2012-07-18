# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf-ng/iptraf-ng-1.1.3.1.ebuild,v 1.4 2012/07/18 13:15:18 blueness Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="A console-based network monitoring utility"
HOMEPAGE="http://fedorahosted.org/iptraf-ng/"
SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2 doc? ( FDL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE="doc"

RESTRICT="test"

RDEPEND=">=sys-libs/ncurses-5.7-r7"
DEPEND="${RDEPEND}
	!net-analyzer/iptraf"

src_prepare() {
	sed -i \
		-e '/^CFLAGS =/s:-g -O2::' -e '/^LDFLAGS =/d' -e '/^CC =/d' \
		Makefile || die
}

src_configure() { :; }

src_compile() {
	tc-export CC
	emake
}

src_install() {
	dosbin {iptraf,rvnamed}-ng

	doman src/*.8
	dodoc AUTHORS CHANGES FAQ README* RELEASE-NOTES
	use doc && dohtml -a gif,html,png -r Documentation/*

	keepdir /var/{lib,log,lock}/iptraf-ng #376157
}

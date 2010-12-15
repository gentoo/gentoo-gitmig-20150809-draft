# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf-ng/iptraf-ng-1.0.2.ebuild,v 1.17 2010/12/15 19:07:08 klausman Exp $

EAPI=2

inherit autotools

DESCRIPTION="console-based network monitoring utility, fork of iptraf 3.0.0"
HOMEPAGE="https://fedorahosted.org/iptraf-ng/"
SRC_URI="https://fedorahosted.org/releases/i/p/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ~ppc64 ~sh sparc x86"
IUSE="static-libs"

DEPEND="
	sys-libs/ncurses
"
RDEPEND="
	!net-analyzer/iptraf
	${DEPEND}
"

src_prepare() {
	sed -i src/Makefile.am -e 's|$(CFLAGS)||g'
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir /var/{lib,run,log}/iptraf
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/diamondx/diamondx-0.1.ebuild,v 1.1 2007/12/05 02:06:59 jer Exp $

DESCRIPTION="DiamondX is a simple NPAPI plugin built to run on Unix platforms
and exercise the XEmbed browser extension."
HOMEPAGE="http://multimedia.cx/diamondx/"
SRC_URI="http://multimedia.cx/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~hppa ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*
	dev-libs/nspr"
RDEPEND=""
RESTRICT="test"

src_install() {
	insinto /usr/lib/nsbrowser/plugins/
	doins .libs/libdiamondx.so

	insinto /usr/share/doc/${P}/examples
	doins test/index.htm test/a.diamondx

	dohtml doc/index.html doc/*.png

	dodoc ChangeLog AUTHORS NEWS README
}

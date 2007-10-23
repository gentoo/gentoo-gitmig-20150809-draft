# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/compiz-fusion-plugins-unsupported/compiz-fusion-plugins-unsupported-0.6.0.ebuild,v 1.2 2007/10/23 23:05:14 hanno Exp $

DESCRIPTION="Compiz Fusion unsupported plugins"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="test"
DEPEND=">=x11-wm/compiz-0.6.0
	>=x11-libs/compiz-bcop-0.6.0"

S="${WORKDIR}/${P}"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

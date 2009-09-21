# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/cardo/cardo-0.98.ebuild,v 1.3 2009/09/21 21:54:20 maekke Exp $

inherit font

DESCRIPTION="Unicode font for classicists, medievalists and linguists"
HOMEPAGE="http://scholarsfonts.net/cardofnt.html"
SRC_URI="http://scholarsfonts.net/${PN}${PV#0.}.zip"
# Distribution is restricted
RESTRICT="mirror"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="Manual98a.pdf"

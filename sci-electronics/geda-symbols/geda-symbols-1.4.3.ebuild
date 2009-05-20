# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-symbols/geda-symbols-1.4.3.ebuild,v 1.1 2009/05/20 02:06:54 calchan Exp $

EAPI="2"

inherit versionator

DESCRIPTION="GPL Electronic Design Automation: symbols"
HOMEPAGE="http://www.gpleda.org/"
SRC_URI="http://geda.seul.org/release/v$(get_version_component_range 1-2)/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="!<sci-electronics/geda-1.4.3-r1"
RDEPEND=""

src_prepare() {
	sed -i -e 's/ documentation//' Makefile.in || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/geany-themes/geany-themes-1.22.1.ebuild,v 1.1 2012/10/29 17:20:38 hasufell Exp $

EAPI=4

DESCRIPTION="A collection of colour schemes for Geany"
HOMEPAGE="https://github.com/codebrainz/geany-themes"
SRC_URI="mirror://github/codebrainz/${PN}/${P}.tar.bz2"

LICENSE="GPL-3 LGPL-2.1 BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="~dev-util/geany-${PV:0:4}"

src_install() {
	insinto /usr/share/geany
	doins -r colorschemes

	dodoc AUTHORS ChangeLog README.md
}

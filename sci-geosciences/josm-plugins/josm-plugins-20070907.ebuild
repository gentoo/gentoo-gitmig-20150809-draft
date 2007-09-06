# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/josm-plugins/josm-plugins-20070907.ebuild,v 1.1 2007/09/06 23:01:54 hanno Exp $

inherit eutils

DESCRIPTION="Set of plugins for josm"
HOMEPAGE="http://josm.eigenheimstrasse.de/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="sci-geosciences/josm"
S="${WORKDIR}/${PN}"
IUSE=""

src_compile() {
	einfo Nothing to compile
}

src_install() {
	insinto /usr/lib/josm/plugins
	doins *.jar
}

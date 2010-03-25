# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subdl/subdl-1.0.2.ebuild,v 1.1 2010/03/25 18:59:32 ssuominen Exp $

EAPI=2
PYTHON_DEPEND="2:2.6"
inherit python

DESCRIPTION="A command-line tool for downloading subs from opensubtitles.org"
HOMEPAGE="http://www.cubewano.org/subdl"
SRC_URI="http://www.cubewano.org/subdl/downloads/1.0.2/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e 's:www.opensubtitles.org:api.opensubtitles.org:' \
		${PN} || die
}

src_install() {
	dobin ${PN} || die
	dodoc README.txt
}

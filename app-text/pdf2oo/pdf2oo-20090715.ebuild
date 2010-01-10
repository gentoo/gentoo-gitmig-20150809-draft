# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdf2oo/pdf2oo-20090715.ebuild,v 1.4 2010/01/10 20:26:04 maekke Exp $

DESCRIPTION="Converts pdf files to odf"
HOMEPAGE="http://sourceforge.net/projects/pdf2oo/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-arch/zip
	app-text/poppler-utils
	media-gfx/imagemagick"

S=${WORKDIR}/${PN}

src_install() {
	dobin pdf2oo || die
	dodoc README || die
}

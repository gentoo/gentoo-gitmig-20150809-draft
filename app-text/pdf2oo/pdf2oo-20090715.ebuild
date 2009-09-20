# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdf2oo/pdf2oo-20090715.ebuild,v 1.1 2009/09/20 04:21:25 darkside Exp $

EAPI="1"

DESCRIPTION="Converts pdf files to odf"
HOMEPAGE="http://sourceforge.net/projects/pdf2oo/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="kde"

# will not work with KDE4, uses DCOP
DEPEND=""
RDEPEND="app-arch/zip
	app-text/poppler-utils
	media-gfx/imagemagick
	kde? ( || ( ( >=kde-base/kdialog-3.5.0:3.5 >=kde-base/kommander-3.5.2:3.5 ) kde-base/kdebase:3.5 )
		>=kde-base/kdelibs-3.5.2-r6:3.5 )"

S="${WORKDIR}/${PN}"

src_install() {
	dobin pdf2oo || die
	dodoc README || die
}

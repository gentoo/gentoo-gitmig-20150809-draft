# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/nepali-fonts/nepali-fonts-1.ebuild,v 1.4 2004/07/14 17:08:00 agriffis Exp $

DESCRIPTION="a collection of fonts for Nepali users"
HOMEPAGE="http://www.mpp.org.np/ http://www.nepali.info/ http://www.nepalipost.com/ http://www.moics.gov.np/download/fonts.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	insinto /usr/share/fonts/${PN}
	doins *.ttf
}

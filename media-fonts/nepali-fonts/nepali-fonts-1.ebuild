# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/nepali-fonts/nepali-fonts-1.ebuild,v 1.2 2004/06/21 16:11:44 usata Exp $

DESCRIPTION="a collection of fonts for Nepali users"
HOMEPAGE="http://www.mpp.org.np/ http://www.nepali.info/ http://www.nepalipost.com/ http://www.moics.gov.np/download/fonts.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	insinto /usr/share/fonts/${PN}
	doins *.ttf
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/nepali-fonts/nepali-fonts-1-r1.ebuild,v 1.6 2004/07/29 19:01:52 kugelfang Exp $

inherit font

DESCRIPTION="a collection of fonts for Nepali users"
HOMEPAGE="http://www.mpp.org.np/ http://www.nepali.info/ http://www.nepalipost.com/ http://www.moics.gov.np/download/fonts.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""

FONT_S=${WORKDIR}/${PN}
FONT_SUFFIX="ttf"

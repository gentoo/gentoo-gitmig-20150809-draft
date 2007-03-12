# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vc-fonts/vc-fonts-20020207-r1.ebuild,v 1.7 2007/03/12 19:39:28 armin76 Exp $

S=${WORKDIR}/vc
DESCRIPTION="Vico bitmap Fonts"
SRC_URI="http://vico.kleinplanet.de/files/${P}.tar.bz2"
HOMEPAGE="http://vico.kleinplanet.de/"

SLOT=0
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 arm ia64 ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"

DEPEND="|| ( x11-apps/mkfontdir virtual/x11 )"
RDEPEND=""
IUSE=""

src_install() {

	insopts -m0644
	insinto /usr/share/fonts/vc
	doins *.pcf.gz fonts.alias
	mkfontdir ${D}/usr/share/fonts/vc
}

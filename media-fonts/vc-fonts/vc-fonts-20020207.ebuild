# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vc-fonts/vc-fonts-20020207.ebuild,v 1.2 2004/07/29 19:06:11 kugelfang Exp $

S=${WORKDIR}/vc
DESCRIPTION="Vico bitmap Fonts"
SRC_URI="http://vico.kleinplanet.de/files/${P}.tar.bz2"
HOMEPAGE="http://vico.kleinplanet.de/"

SLOT=0
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~amd64"

DEPEND="virtual/x11"
RDEPEND="X? ( virtual/x11 )"
IUSE="X"

src_install() {

	insopts -m0644
	insinto /usr/share/fonts/vc
	doins *.pcf.gz fonts.alias
	mkfontdir ${D}/usr/share/fonts/vc
}

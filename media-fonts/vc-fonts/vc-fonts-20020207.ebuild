# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/vc-fonts/vc-fonts-20020207.ebuild,v 1.6 2005/08/23 21:37:19 gustavoz Exp $

S=${WORKDIR}/vc
DESCRIPTION="Vico bitmap Fonts"
SRC_URI="http://vico.kleinplanet.de/files/${P}.tar.bz2"
HOMEPAGE="http://vico.kleinplanet.de/"

SLOT=0
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"

DEPEND="virtual/x11"
RDEPEND="X? ( virtual/x11 )"
IUSE="X"

src_install() {

	insopts -m0644
	insinto /usr/share/fonts/vc
	doins *.pcf.gz fonts.alias
	mkfontdir ${D}/usr/share/fonts/vc
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arabeyes-fonts/arabeyes-fonts-1.1.ebuild,v 1.2 2004/10/14 20:01:48 dholm Exp $

inherit font

MY_PN="ae_fonts1"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="Arabeyes Arabic TrueType fonts"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Khotot"
SRC_URI="mirror://sourceforge/arabeyes/${MY_PN}_ttf_${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

FONT_SUFFIX="ttf"

DOCS="license.txt"

src_install() {
	for d in AAHS AGA FS Kasr MCS Shmookh; do
		FONT_S=${S}/$d
		font_src_install
	done
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arabeyes-fonts/arabeyes-fonts-1.1.ebuild,v 1.12 2007/06/29 07:04:07 opfer Exp $

inherit font

MY_PN="ae_fonts1"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="Arabeyes Arabic TrueType fonts"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Khotot"
SRC_URI="mirror://sourceforge/arabeyes/${MY_PN}_ttf_${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttf"

DOCS="license.txt"

src_install() {
	for d in AAHS AGA FS Kasr MCS Shmookh; do
		FONT_S=${S}/$d
		font_src_install
	done
}

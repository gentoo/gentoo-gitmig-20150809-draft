# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/baekmuk-fonts/baekmuk-fonts-2.2-r1.ebuild,v 1.2 2006/03/20 03:13:56 vapier Exp $

inherit font font-ebdftopcf

TTF_P="${P/fonts/ttf}"
BDF_P="${P/fonts/bdf}"
UNI_P="20020418"

DESCRIPTION="Korean Baekmuk Font"
HOMEPAGE="http://kldp.net/projects/baekmuk/"
SRC_URI="X? ( http://kldp.net/download.php/1429/${TTF_P}.tar.gz )
	http://kldp.net/download.php/1428/${BDF_P}.tar.gz
	unicode? ( http://chem.skku.ac.kr/~wkpark/baekmuk/iso10646/${UNI_P}.tar.bz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~sh ~sparc ~x86"
IUSE="unicode X"

S="${WORKDIR}"

src_unpack() {
	unpack ${BDF_P}.tar.gz
	use X && unpack ${TTF_P}.tar.gz

	if use unicode ; then
		cd ${WORKDIR}/${BDF_P}/bdf
		unpack ${UNI_P}.tar.bz2
	fi
}

src_compile() {
	cd ${BDF_P}/bdf
	font-ebdftopcf_src_compile
}

src_install () {
	use X && FONT_S=${S}/${TTF_P}/ttf FONT_SUFFIX="ttf" font_src_install
	FONT_S=${S}/${BDF_P}/bdf FONT_SUFFIX="pcf.gz" font_src_install
}

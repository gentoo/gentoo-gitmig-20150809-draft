# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/baekmuk-fonts/baekmuk-fonts-2.2.ebuild,v 1.6 2004/10/19 10:24:27 absinthe Exp $

inherit font

IUSE="unicode X"

TTF_P="${P/fonts/ttf}"
BDF_P="${P/fonts/bdf}"
UNI_P="20020418"

DESCRIPTION="Korean Baekmuk Font"
HOMEPAGE="http://kldp.net/projects/baekmuk/"
SRC_URI="X? ( http://kldp.net/download.php/1429/${TTF_P}.tar.gz )
	http://kldp.net/download.php/1428/${BDF_P}.tar.gz
	unicode? ( http://chem.skku.ac.kr/~wkpark/baekmuk/iso10646/${UNI_P}.tar.bz2 )"

LICENSE="BSD"
KEYWORDS="~ia64 x86 alpha ppc sparc hppa amd64 ~mips ~ppc64"
SLOT="0"

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
	cd ${BDF_P}
	mkdir pcf
	for i in bdf/*.bdf ; do
		echo "Converting ${i##*/} into pcf format ..."
		bdftopcf $i | gzip -c -9 > ${i//bdf/pcf}.gz || die
	done
}

src_install () {

	if use X ; then
		FONT_S=${S}/${TTF_P}/ttf FONT_SUFFIX="ttf" font_src_install
	fi

	FONT_S=${S}/${BDF_P}/pcf FONT_SUFFIX="pcf.gz" font_src_install
}

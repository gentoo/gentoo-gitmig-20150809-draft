# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/jisx0213-fonts/jisx0213-fonts-1.03.ebuild,v 1.3 2004/02/04 00:19:33 augustus Exp $

IUSE="X"

DESCRIPTION="Japanese JIS0213 fonts"

HOMEPAGE="http://www.mars.sphere.ne.jp/imamura/jisx0213.html"
SRC_BASE1=http://www.mars.sphere.ne.jp/imamura
SRC_BASE2=http://gitatsu.hp.infoseek.co.jp/bdf
SRC_URI="${SRC_BASE1}/jiskan16-2000-1.bdf.gz
	${SRC_BASE1}/jiskan16-2000-2.bdf.gz
	${SRC_BASE1}/K14-1.bdf.gz
	${SRC_BASE1}/K14-2.bdf.gz
	${SRC_BASE1}/K14-2.bdf.gz
	${SRC_BASE1}/A14.bdf.gz
	${SRC_BASE1}/A12.bdf.gz
	${SRC_BASE2}/jiskan24-2000-1.bdf.gz
	${SRC_BASE2}/jiskan24-2000-2.bdf.gz"

LICENSE="public-domain"
SLOT="0"

KEYWORDS="x86 ~alpha ~sparc ~ppc ~amd64"

DEPEND="virtual/x11"
RDEPEND="X? ( virtual/x11 )"

S=${WORKDIR}
FONTDIR="/usr/share/fonts/jisx0213"

src_compile() {

	for i in *.bdf; do
		echo "Converting $i into pcf format..."
		bdftopcf -o ${i/bdf/pcf} $i
		gzip -9 ${i/bdf/pcf}
	done
}

src_install() {

	insinto ${FONTDIR}
	doins *.pcf.gz
	use X && mkfontdir ${D}/${FONTDIR}
}

pkg_postinst(){
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}\""
	einfo ""
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}\""
	einfo ""
}

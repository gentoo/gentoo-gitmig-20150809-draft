# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1.ebuild,v 1.1 2003/06/02 13:45:18 seemant Exp $

DESCRIPTION="Arphic Fonts"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz"
HOMEPAGE="http://www.arphic.com.tw/"
LICENSE="Arphic"
SLOT="0"
KEYWORDS="x86 sparc ppc"

DEPEND="virtual/x11
	x11-misc/ttmkfdir"

src_unpack() {
	mkdir ${WORKDIR}/${P}
	gunzip -c ${DISTDIR}/gkai00mp.ttf.gz > ${WORKDIR}/${P}/gkai00mp.ttf
	gunzip -c ${DISTDIR}/bkai00mp.ttf.gz > ${WORKDIR}/${P}/bkai00mp.ttf
	gunzip -c ${DISTDIR}/bsmi00lp.ttf.gz > ${WORKDIR}/${P}/bsmi00lp.ttf
	gunzip -c ${DISTDIR}/gbsn00lp.ttf.gz > ${WORKDIR}/${P}/gbsn00lp.ttf
}

src_compile() {
	echo "Truetype fonts don't need to be compiled! ;)"
}

src_install() {
	cd ${WORKDIR}/${P}
	insopts -m0644
	insinto /usr/share/fonts/truetype
	doins *.ttf

#	These don't get downloaded because there is no simple way to 
#	fetch them.. ie if I included the README in SRC_URI above, it would
#	get saved as ${DISTDIR}/README which doesn't seem like
#	a really good idea.
#	dodoc LICENSE README
}

pkg_postinst() {
	echo ">>> Making font dirs..."
	cd /usr/share/fonts/truetype/
	/usr/X11R6/bin/ttmkfdir > fonts.scale	
	mkfontdir
}

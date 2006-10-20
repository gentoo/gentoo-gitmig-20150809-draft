# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1.20060513.ebuild,v 1.5 2006/10/20 21:21:29 kloeri Exp $

inherit font

DESCRIPTION="Chinese TrueType Arphic Fonts"
HOMEPAGE="http://www.arphic.com.tw/
	http://www.freedesktop.org/wiki/Software_2fCJKUnifonts"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz
	mirror://debian/pool/main/t/ttf-arphic-uming/ttf-arphic-uming_${PV}.orig.tar.gz
	mirror://debian/pool/main/t/ttf-arphic-ukai/ttf-arphic-ukai_${PV}.orig.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ~ppc-macos ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE="X"

S=${WORKDIR}

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	unpack ${A}
	cd "${S}/ttf-arphic-ukai-${PV}"
	mv ukai.ttf "${S}"
	cd "${S}/ttf-arphic-uming-${PV}"
	mv uming.ttf "${S}"
}

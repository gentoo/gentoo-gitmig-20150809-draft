# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/zh-kcfonts/zh-kcfonts-1.05-r1.ebuild,v 1.6 2005/08/13 23:36:16 flameeyes Exp $

KCFONTS="${P}.tgz"

DESCRIPTION="Kuo Chauo Chinese Fonts collection in BIG5 encoding"
SRC_URI="ftp://ftp.freebsd.org.tw/pub/releases/i386/4.9-RELEASE/packages/x11-fonts/${P}.tgz"
HOMEPAGE=""	#No homepage exists that I am aware of or able to find

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

DEPEND="virtual/x11"
S=${WORKDIR}
FONTPATH=/usr/share/fonts/${PN}

src_install() {
	insinto ${FONTPATH}
	doins lib/X11/fonts/local/*gz || die
	sort lib/X11/fonts/local/kc_fonts.alias | uniq > ${T}/fonts.alias
	doins ${T}/fonts.alias || die
	mkfontdir ${D}/${FONTPATH}
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/zh-kcfonts/zh-kcfonts-1.05-r1.ebuild,v 1.10 2006/03/23 21:18:51 spyderous Exp $

KCFONTS="${P}.tgz"

DESCRIPTION="Kuo Chauo Chinese Fonts collection in BIG5 encoding"
SRC_URI="ftp://ftp.freebsd.org.tw/pub/releases/i386/4.9-RELEASE/packages/x11-fonts/${P}.tgz"
HOMEPAGE="http://freebsd.sinica.edu.tw/"
# no real homepage exists, but this was written by Taiwanese FreeBSD devs

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	|| ( ( x11-apps/bdftopcf
			x11-apps/mkfontdir
		)
		virtual/x11
	)"
S=${WORKDIR}
FONTPATH=/usr/share/fonts/${PN}

src_install() {
	insinto ${FONTPATH}
	doins lib/X11/fonts/local/*gz || die
	sort lib/X11/fonts/local/kc_fonts.alias | uniq > ${T}/fonts.alias
	doins ${T}/fonts.alias || die
	mkfontdir ${D}/${FONTPATH}
}

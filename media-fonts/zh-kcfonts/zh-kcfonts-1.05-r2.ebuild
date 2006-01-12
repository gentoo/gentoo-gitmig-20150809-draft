# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/zh-kcfonts/zh-kcfonts-1.05-r2.ebuild,v 1.1 2006/01/12 00:42:06 robbat2 Exp $

inherit toolchain-funcs eutils

KCFONTS="${P}.tgz"

MY_PN="kcfonts"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Kuo Chauo Chinese Fonts collection in BIG5 encoding"
SRC_URI="ftp://freebsd.sinica.edu.tw/pub/distfiles/${MY_P}.tar.gz
		ftp://wm28.csie.ncu.edu.tw/pub/distfiles/${MY_P}.tar.gz
		mirror://gentoo/${MY_P}-freebsd-aa_ad.patch.gz"
HOMEPAGE="http://freebsd.sinica.edu.tw/"
# no real homepage exists, but this was written by Taiwanese FreeBSD devs

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( ( x11-apps/mkfontdir x11-apps/bdftopcf ) virtual/x11 )"
RDEPEND=""
S="${WORKDIR}"
FONTPATH="/usr/share/fonts/${PN}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	EPATCH_OPTS="-p0 -d ${S}" epatch ${DISTDIR}/${MY_P}-freebsd-aa_ad.patch.gz
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${MY_P}-code-fixups.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	insinto ${FONTPATH}
	doins *.pcf.gz || die
	sort kc_fonts.alias | uniq > ${T}/fonts.alias
	doins ${T}/fonts.alias || die
	mkfontdir ${D}/${FONTPATH}
	dodoc 00README Xdefaults.*
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/baekmuk-fonts/baekmuk-fonts-2.1-r1.ebuild,v 1.5 2004/01/09 22:41:55 weeve Exp $

IUSE="X truetype"

DESCRIPTION="Korean Baekmuk Font"
SRC_URI="http://gentoo.or.kr/distfiles/baekmuk-fonts/${P}.tar.gz"
HOMEPAGE="http://www.mizi.co.kr/ko/prod/etc/mos-pro2.htm"

SLOT="0"
LICENSE="BAEKMUK"
KEYWORDS="ia64 x86 alpha ~ppc sparc hppa amd64"

DEPEND="virtual/x11
	truetype? ( virtual/xft )"
RDEPEND="X? ( virtual/x11
	truetype? ( virtual/xft ) )"

S=${WORKDIR}/${P}
FONTDIR="/usr/share/fonts/baekmuk"
TTFONTDIR="/usr/share/fonts/ttf/korean/baekmuk"

src_compile() {
	mkdir pcf
	for i in bdf/*.bdf ; do
		echo "Converting ${i##*/} into pcf format ..."
		bdftopcf $i | gzip -c -9 > ${i//bdf/pcf}.gz || die
	done
}

src_install () {

	insinto ${FONTDIR}
	doins pcf/* || die

	if [ -n "`use X`" ] ; then
		mkfontdir ${D}${FONTDIR}
		if [ -n "`use truetype`" ] ; then
			insinto ${TTFONTDIR}
			doins ttf/* || die
			mkfontscale ${D}${TTFONTDIR}
			fc-cache ${D}${TTFONTDIR}
		fi
	fi

	# these files seem to be 0 byte??
	#dodoc README COPYRIGHT COPYRIGHT.ks hconfig.ps
}

pkg_postinst() {
	if [ -n "`use X`" ] ; then
		einfo
		einfo "You MUST add the path of Baekmuk fonts in /etc/X11/XF86Config"
		einfo ""
		einfo "Section \"Files\""
		einfo "\tFontPath \"${FONTDIR}\""
		use truetype >/dev/null 2>&1 && \
			einfo "\tFontPath \"${TTFONTDIR}\""
		einfo ""
		einfo "And you must restart your X server."
		einfo ""
	fi
}

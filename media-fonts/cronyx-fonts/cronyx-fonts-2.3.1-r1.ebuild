# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/cronyx-fonts/cronyx-fonts-2.3.1-r1.ebuild,v 1.9 2007/07/15 05:13:09 mr_bones_ Exp $

DESCRIPTION="Cronyx Cyrillic bitmap fonts for X"
HOMEPAGE="http://koi8.pp.ru/frame.html?xwin.html#xwin_fonts"
S=${WORKDIR}/cyrillic
SRC_URI="http://koi8.pp.ru/dist/x6rus-${PV}-bin.tgz"
KEYWORDS="alpha amd64 ppc sparc x86"
SLOT="0"
LICENSE="freedist"
DEPEND="X? ( || ( x11-apps/mkfontdir virtual/x11 ) )"
IUSE="X"

FONT_ROOT=/usr/share/fonts/cronyx
FONT_TARGETS="75dpi 100dpi misc"

src_install() {
	for dir in $FONT_TARGETS; do
		insinto ${FONT_ROOT}/$dir
		doins ${dir}/*.pcf.gz
	done
	# our install dir is still ${FONT_ROOT}/misc, so
	doins misc/fonts.alias
	dodoc xrus.info
}

rebuild_fontfiles() {
	einfo "Refreshing fonts.scale and fonts.dir..."
	cd ${FONT_ROOT}
	mkfontdir -- ${FONT_TARGETS}
	if [ "${ROOT}" = "/" ] &&  [ -x /usr/bin/fc-cache ]
	then
		einfo "Updating font cache..."
		HOME="/root" /usr/bin/fc-cache -f ${FONT_TARGETS}
	fi
}

pkg_postinst() {
	if use X > /dev/null ; then
		rebuild_fontfiles
		elog "In order to make X see the fonts, you need to add the"
		elog "following lines to the files section of your "
		elog "/etc/X11/XF86Config (or the XOrg equivalent):"
		elog "  FontPath \"${FONT_ROOT}/100dpi/:unscaled\""
		elog "  FontPath \"${FONT_ROOT}/misc/:unscaled\""
		elog "  FontPath \"${FONT_ROOT}/75dpi/:unscaled\""
		elog ""
		elog "In order to make them accessible to your current X"
		elog "session, run:"
		elog "  xset fp+ ${FONT_ROOT}/100dpi/:unscaled,\\"
		elog "${FONT_ROOT}/misc/:unscaled,\\"
		elog "${FONT_ROOT}/75dpi/:unscaled"
		elog "  xset fp rehash"
	fi
}

pkg_postrm() {
	if use X > /dev/null ; then
		rebuild_fontfiles
	fi
}

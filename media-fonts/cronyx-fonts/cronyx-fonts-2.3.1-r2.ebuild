# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/cronyx-fonts/cronyx-fonts-2.3.1-r2.ebuild,v 1.5 2006/10/20 21:22:12 kloeri Exp $

DESCRIPTION="Cronyx Cyrillic bitmap fonts for X"
HOMEPAGE="http://koi8.pp.ru/frame.html?xwin.html#xwin_fonts"
S="${WORKDIR}/cyrillic"
SRC_URI="http://koi8.pp.ru/dist/x6rus-${PV}-bin.tgz"
KEYWORDS="alpha ~amd64 arm ia64 ~ppc s390 sh sparc ~x86"
SLOT="0"
LICENSE="freedist"
DEPEND="X? ( || ( x11-apps/mkfontdir virtual/x11 ) )"
RDEPEND=""
IUSE="X"

FONT_ROOT=/usr/share/fonts/cronyx
FONT_TARGETS="75dpi 100dpi misc"

src_install() {
	for dir in ${FONT_TARGETS}; do
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
		einfo "In order to make X see the fonts, you need to add the"
		einfo "following lines to the files section of your "
		einfo "/etc/X11/XF86Config (or the XOrg equivalent):"
		einfo "  FontPath \"${FONT_ROOT}/100dpi/:unscaled\""
		einfo "  FontPath \"${FONT_ROOT}/misc/:unscaled\""
		einfo "  FontPath \"${FONT_ROOT}/75dpi/:unscaled\""
		einfo ""
		einfo "In order to make them accessible to your current X"
		einfo "session, run:"
		einfo "  xset fp+ ${FONT_ROOT}/100dpi/:unscaled,\\"
		einfo "${FONT_ROOT}/misc/:unscaled,\\"
		einfo "${FONT_ROOT}/75dpi/:unscaled"
		einfo "  xset fp rehash"
	fi
}

pkg_postrm() {
	if use X > /dev/null ; then
		rebuild_fontfiles
	fi
}

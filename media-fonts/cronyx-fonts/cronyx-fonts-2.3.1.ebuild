# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/cronyx-fonts/cronyx-fonts-2.3.1.ebuild,v 1.2 2004/07/06 11:01:40 dholm Exp $

DESCRIPTION="Cronyx Cyrillic bitmap fonts for X"
HOMEPAGE="http://koi8.pp.ru/frame.html?xwin.html#xwin_fonts"
S=${WORKDIR}/cyrillic
SRC_URI="http://koi8.pp.ru/dist/x6rus-${PV}-bin.tgz"
KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="freedist"
DEPEND="X? ( virtual/x11 )"
IUSE="X"

FONT_ROOT=/usr/share/fonts
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
	use X > /dev/null && rebuild_fontfiles
}

pkg_postrm() {
	use X > /dev/null && rebuild_fontfiles
}

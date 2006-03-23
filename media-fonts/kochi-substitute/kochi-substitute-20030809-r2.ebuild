# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/kochi-substitute/kochi-substitute-20030809-r2.ebuild,v 1.5 2006/03/23 21:00:40 spyderous Exp $

IUSE="X"

DESCRIPTION="Kochi Japanese TrueType fonts with Wadalab Fonts"
HOMEPAGE="http://efont.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/efont/5411/${P}.tar.bz2"

# naga10 has free-noncomm license
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~alpha ~sparc ~ppc ~hppa ~amd64 ~mips ppc64"

DEPEND="virtual/libc
	X? ( || ( ( x11-apps/mkfontdir
				x11-apps/ttmkfdir
				media-libs/fontconfig
			)
			virtual/x11
		)
	)"

S=${WORKDIR}/${PN}-${PV:0:8}
FONTPATH="/usr/share/fonts/${PN}"

src_install () {

	insinto ${FONTPATH}
	doins kochi-gothic-subst.ttf
	doins kochi-mincho-subst.ttf
	dosym kochi-gothic-subst.ttf ${FONTPATH}/kochi-gothic.ttf
	dosym kochi-mincho-subst.ttf ${FONTPATH}/kochi-mincho.ttf
	dodir /usr/X11R6/lib/X11/fonts/truetype
	for f in ${D}${FONTPATH}/*.ttf ; do
		dosym ${f/${D}/} /usr/X11R6/lib/X11/fonts/truetype
	done
	mkfontscale ${D}${FONTPATH}
	newins ${D}${FONTPATH}/fonts.scale fonts.dir
	if [ -x /usr/bin/fc-cache ] ; then
		/usr/bin/fc-cache -f ${D}${FONTPATH}
	fi

	dodoc README.ja COPYING docs/README
	cd docs
	for d in kappa20 k14goth ayu20gothic wadalab shinonome* naga10; do
		docinto $d
		dodoc $d/*
	done
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/kochi-substitute/kochi-substitute-20030628.ebuild,v 1.2 2003/07/04 16:04:52 gmsoft Exp $

IUSE="X"

FONT_PATH="/usr/X11R6/lib/X11/fonts/truetype"
DESCRIPTION="Kochi Japanese TrueType fonts with Wadalab Fonts"
HOMEPAGE="http://efont.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/efont/4845/${P}.tar.bz2"

# naga10 has free-noncomm license
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc hppa"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

S=${WORKDIR}/${PN}-${PV:0:8}

src_install () {

	insinto ${FONT_PATH}
	doins kochi-gothic-subst.ttf
	doins kochi-mincho-subst.ttf
	dosym kochi-gothic-subst.ttf ${FONT_PATH}/kochi-gothic.ttf
	dosym kochi-mincho-subst.ttf ${FONT_PATH}/kochi-mincho.ttf

	dodoc README.ja COPYING docs/README
	cd docs
	for d in kappa20 k14goth ayu20gothic wadalab shinonome* naga10; do
		docinto $d
		dodoc $d/*
	done
}

rebuild_fontfiles() {

	einfo "Refreshing fonts.scale and fonts.dir..."

	cd ${FONT_PATH}

	# recreate fonts.scale
	ttmkfdir > fonts.scale \
		|| die "Unable to create fonts.scale! Please emerge ttmkfdir and try again."

	# recreate fonts.dir
	mkfontdir -e /usr/X11R6/lib/X11/fonts/encodings

	if [ -x /usr/bin/fc-cache ] ; then
		einfo "Updating font cache..."
		/usr/bin/fc-cache -f ${FONT_PATH}
	fi
}

pkg_postinst() {

	use X > /dev/null && rebuild_fontfiles

	echo ""
	einfo "This is a Kochi \"alternative\" font, but not kochi font itself."
	einfo "Unfortunately, there is a possibility of copyright infringement,"
	einfo "so the author of kochi font suspended distributing kochi font."
	einfo "Please see http://khdd.net/kanou/fonts/stolenbitmap.en.html and"
	einfo "${HOMEPAGE} for details."
}

pkg_postrm() {

	use X > /dev/null && rebuild_fontfiles
}

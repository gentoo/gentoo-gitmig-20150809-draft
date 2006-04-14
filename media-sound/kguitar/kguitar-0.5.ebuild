# Copyright 1999-2006 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kguitar/kguitar-0.5.ebuild,v 1.1 2006/04/14 23:52:46 eldad Exp $

inherit kde

need-kde 3.0

DESCRIPTION="An efficient and easy-to-use environment for a guitarist"
HOMEPAGE="http://kguitar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86"

SLOT="0"

IUSE="tetex"

# hard-dep on tse3, without it causes Settings->Configure KGuitar to crash. (eldad 15 April 2006)
DEPEND=">=media-libs/tse3-0.2.3
	tetex? ( app-text/tetex )"

src_compile() {
	myconf="--with-tse3 $(use_with tetex kgtabs)"
	kde_src_compile
}

pkg_postinst() {
	if use tetex ; then
		einfo "Running texhash"
		texhash

		ewarn "In order to print chords you'll need musixtex, which provides tetex macros and fonts."
		ewarn "See:"
		ewarn "	 http://directory.fsf.org/MusiXTex.html"
	fi
}

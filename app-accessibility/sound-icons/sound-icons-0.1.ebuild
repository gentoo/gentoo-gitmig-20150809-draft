# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sound-icons/sound-icons-0.1.ebuild,v 1.1 2007/09/12 06:01:35 williamh Exp $

DESCRIPTION="a collection of Sound Icons for speech-dispatcher"
HOMEPAGE="http://www.freebsoft.org"
SRC_URI="http://www.freebsoft.org/pub/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-accessibility/speech-dispatcher"

src_compile(){
	einfo "Nothing to compile."
}

src_install() {
	dodoc README
	insinto /usr/share/sounds/sound-icons
	doins ${S}/*.wav
	links="`find ${S} -type l -print`"
	for link in $links; do
		target=`readlink -n $link`
		dosym $target /usr/share/sounds/sound-icons/`basename $link`
	done
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-tremulous/quake3-tremulous-1.0.2.ebuild,v 1.2 2005/10/25 05:04:28 mr_bones_ Exp $

MOD_DESC="modification blending a team based FPS with elements of an RTS"
MOD_NAME="tremulous"
inherit games games-q3mod

HOMEPAGE="http://tremulous.net"
SRC_URI="mirror://sourceforge/tremulous/tremulous-q3-${PV}-installer.x86.run"

LICENSE="OSML"
SLOT="0"

src_unpack() {
	cd "${S}"

	unpack_makeself "${A}"

	rm postinstall.sh preuninstall.sh || die
	rm tremulous-${PV}-src.tar.gz.notatarball || die
	rm -rf setup.sh setup.data/ || die
	rm -rf bin/ || die

	mkdir docs share || die
	mv *.txt *.pdf COPYING ChangeLog docs/ || die
	mv tremulous.xpm share/ || die
}


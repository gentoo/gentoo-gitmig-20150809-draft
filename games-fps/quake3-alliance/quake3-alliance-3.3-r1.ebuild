# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-alliance/quake3-alliance-3.3-r1.ebuild,v 1.4 2009/10/06 22:10:02 nyhm Exp $

EAPI=2

MOD_DESC="fast paced, off-handed grapple mod"
MOD_NAME="Alliance"
MOD_DIR="alliance"

inherit games games-mods

SRC_URI="http://www.mirrorservice.org/sites/quakeunity.com/modifications/alliance/alliance30.zip
	http://www.superkeff.net/mods/mods/alliance/alliance30.zip
	http://www.mirrorservice.org/sites/quakeunity.com/modifications/alliance/alliance30-33.zip
	http://www.superkeff.net/mods/mods/alliance/alliance30-33.zip"
HOMEPAGE="http://www.planetquake.com/alliance/"

LICENSE="freedist"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"

src_unpack() {
	unpack alliance30.zip alliance30-33.zip
}

src_prepare() {
	rm -f *.exe
}

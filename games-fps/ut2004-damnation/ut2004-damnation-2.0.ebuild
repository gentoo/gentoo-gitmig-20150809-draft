# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-damnation/ut2004-damnation-2.0.ebuild,v 1.4 2009/10/08 23:01:10 nyhm Exp $

EAPI=2

MOD_DESC="steampunk fantasy/western action/adventure mod"
MOD_NAME="Damnation"
MOD_DIR="Damnation"

inherit eutils games games-mods

HOMEPAGE="http://www.moddb.com/mods/damnation"
SRC_URI="mirror://liflg/damnation_${PV}-english.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

src_unpack() {
	unpack_makeself
	unpack ./damnation_${PV}-english.tar.bz2
}

src_prepare() {
	rm -rf bin setup.data
	rm -f 3339* *.bz2 README* *.sh
}

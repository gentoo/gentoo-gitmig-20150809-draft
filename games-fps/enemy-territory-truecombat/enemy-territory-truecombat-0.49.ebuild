# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-truecombat/enemy-territory-truecombat-0.49.ebuild,v 1.2 2006/10/03 22:23:31 wolf31o2 Exp $

MOD_DESC="True Combat"
MOD_NAME=tcetest

inherit games games-etmod

HOMEPAGE="http://truecombat.com/"
SRC_URI="http://dragons-perch.net/tce/tcetest049.zip
	http://freeserver.name/files/installer/linux/tcetest049.zip
	http://mirror.rosvosektori.net/tcetest049.zip"

LICENSE="as-is"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv tcetest/* .
}

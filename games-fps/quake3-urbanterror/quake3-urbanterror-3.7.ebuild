# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-3.7.ebuild,v 1.1 2004/08/31 21:31:11 wolf31o2 Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME=q3ut3
MOD_BINS=ut3
inherit games games-q3mod

HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="ftp://ftp.edome.net/online/clientit/urbanterror3.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror31.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror32.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror33.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror34.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror35.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror36.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror37.zip
	http://www.clan-nua.com/~mods/Urban.Terror/UrbanTerror35.zip
	http://outlands.slofaca.net/files/UrbanTerror36.zip
	ftp://ftp.snt.utwente.nl/pub/games/urbanterror/patches/UrbanTerror36.zip
	http://outlands.quaddown.org/files/UrbanTerror37.zip
	http://outlands.slofaca.net/files/UrbanTerror37.zip"

LICENSE="freedist"
SLOT="3"
RESTRICT="nomirror"

src_unpack() {
	unpack urbanterror3.zip
	cd q3ut3
	unpack UrbanTerror31.zip
	unpack UrbanTerror32.zip
	unpack UrbanTerror33.zip
	unpack UrbanTerror34.zip
	unpack UrbanTerror35.zip
	unpack UrbanTerror36.zip
	unpack UrbanTerror37.zip
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-3.6.ebuild,v 1.1 2004/06/05 21:30:27 wolf31o2 Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME=q3ut3
MOD_BINS=ut3
inherit games games-q3mod

HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="http://box3.fsk405.org/q3ut3/urbanterror3.zip
	http://kickassctf.com/q3ut3/urbanterror3.zip
	http://www.midwestmayhem.com/urbanterror3.zip
	ftp://www.playdedicated.com/pub/sid/quake3/urbanterror3.zip
	ftp://ftp.edome.net/online/clientit/urbanterror3.zip
	ftp://urtcentral.com/sidstuff/urbanterror3.zip
	http://fsk405.org/3.1/UrbanTerror31.zip
	http://urbanservers.com/files/UrbanTerror31.zip
	http://s3.urbanservers.com/UrbanTerror31.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror31.zip
	http://www.kickassctf.com/q3ut3/UrbanTerror32.zip
	ftp://www.playdedicated.com/pub/sid/quake3/UrbanTerror32.zip
	ftp://ftp.mportal.hu/realmods/q3/urbanterror/UrbanTerror32.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror32.zip
	http://www.kickassctf.com/q3ut3/UrbanTerror33.zip
	ftp://ftp.edome.net/online/clientit/UrbanTerror33.zip
	ftp://www.playdedicated.com/pub/sid/quake3/UrbanTerror33.zip
	http://www.fsk405.org/q3ut3/UrbanTerror34.zip
	ftp://www.playdedicated.com/pub/sid/quake3/UrbanTerror34.zip
	ftp://www.urtcentral.com/sidstuff/UrbanTerror34.zip
	http://www.againtblackdude.com/q3ut3/UrbanTerror35.zip
	http://www.fsk405.org/q3ut3/UrbanTerror35.zip
	http://www.clan-nua.com/~mods/Urban.Terror/UrbanTerror35.zip
	http://www.noleafclover.net/UrbanTerror36.zip
	http://outlands.slofaca.net/files/UrbanTerror36.zip
	ftp://ftp.snt.utwente.nl/pub/games/urbanterror/patches/UrbanTerror36.zip"

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
}

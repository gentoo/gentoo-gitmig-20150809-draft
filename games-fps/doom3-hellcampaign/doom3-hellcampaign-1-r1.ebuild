# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-hellcampaign/doom3-hellcampaign-1-r1.ebuild,v 1.3 2009/10/01 20:54:00 nyhm Exp $

MOD_DESC="map pack for Doom 3"
MOD_NAME="Hell Campaign"
MOD_DIR="hell_campaign"
MOD_BINS="hellcampaign"

inherit games games-mods

HOMEPAGE="http://doom3.filefront.com/file/The_Ultimate_Hell_Campaign;52013"
SRC_URI="mirror://filefront/Doom_III/Maps/Map_Packs/sp_hc_final.zip
	mirror://filefront/Doom_III/Maps/Map_Packs/hardcorehellcampaign_patch.zip"

LICENSE="as-is"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

S=${WORKDIR}

src_unpack() {
	games-mods_src_unpack
	cd "${S}"

	# Prevent "non-portable" upper-case-filename warnings in Doom 3
	mv "Hardcore Hell Campaign.pk4" hardcore_hell_campaign.pk4
	mv Q2Textures.pk4 q2Textures.pk4
	mv Q3Textures.pk4 q3Textures.pk4

	# Show nice description in "mods" menu within Doom 3
	echo 'Hell Campaign' > description.txt
	mkdir -p ${MOD_DIR}
	mv *.txt *.pk4 ${MOD_DIR} || die
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-defrag/quake3-defrag-1.91.08-r1.ebuild,v 1.2 2006/10/23 21:54:32 wolf31o2 Exp $

MOD_DESC="Trickjumping challenges for Quake III"
MOD_NAME="Defrag"
MOD_DIR="defrag"
inherit games games-mods

HOMEPAGE="http://www.planetquake.com/defrag/"
SRC_URI="http://cgg0.free.fr/defrag/defrag_${PV}.zip
	http://www.german-defrag.de/files/defrag/defragpak1.zip
	http://www.german-defrag.de/files/defrag/defragpak2.zip
	http://www.german-defrag.de/files/defrag/defragpak3.zip
	http://www.german-defrag.de/files/defrag/defragpak4.zip
	http://www.german-defrag.de/files/defrag/defragpak5.zip
	http://www.german-defrag.de/files/defrag/defragcpmpak01.zip
	http://www.german-defrag.de/files/defrag/defragpak7.zip
	http://www.german-defrag.de/files/defrag/defragpak8.zip
	http://www.german-defrag.de/files/defrag/defragpak9.zip
	http://www.german-defrag.de/files/defrag/defragpak10.zip
	http://www.german-defrag.de/files/defrag/defragpak11.zip
	http://www.german-defrag.de/files/defrag/df-extras002.zip"

LICENSE="freedist"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"

src_unpack() {
	unpack defrag_${PV}.zip
	cd defrag
	unpack defragpak{1,2,3,4,5,7,8,9,10,11}.zip
	unpack defragcpmpak01.zip
	unpack df-extras002.zip
	mv DeFRaG/* . && rm -r DeFRaG
	mv *.txt docs/
	# imo, the following is just cruft to be pruned
	rm defrag141.zip
	rm -rf misc/{mirc-script,misc,tools}
}

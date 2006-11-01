# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-eventhorizon/doom3-eventhorizon-1.2.ebuild,v 1.1 2006/11/01 21:48:58 wolf31o2 Exp $

MOD_DESC="single-player mission based on the Event Horizon film"
MOD_NAME="Event Horizon"
MOD_DIR="eventhorizon"

inherit games games-mods

HOMEPAGE="http://doom3.filefront.com/file/Event_Horizon;57651"
SRC_URI="mirror://filefront/Doom_III/Maps/Single_Player/event_horizon_${PV}.zip"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

src_unpack() {
	games-mods_src_unpack
	# Standardize directory name.
	local dir=$(find . -maxdepth 1 -name "event_horizon*" -type d)
	mv "${dir}" "${MOD_DIR}" || die "mv ${dir} failed"
}

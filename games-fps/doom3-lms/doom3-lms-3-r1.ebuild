# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-lms/doom3-lms-3-r1.ebuild,v 1.1 2006/10/30 23:42:14 wolf31o2 Exp $

MOD_DESC="add co-op support and/or play against swarms of unending monsters"
MOD_NAME="Last Man Standing"
MOD_DIR="lms${PV}"

inherit games games-mods

HOMEPAGE="http://lms.d3files.com/"
SRC_URI="mirror://filefront/Doom_III/Hosted_Mods/Final_Releases/lms_${PV}_multiplatform.zip"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

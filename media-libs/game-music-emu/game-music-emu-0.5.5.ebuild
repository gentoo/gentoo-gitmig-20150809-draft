# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/game-music-emu/game-music-emu-0.5.5.ebuild,v 1.4 2011/01/13 21:51:18 ranger Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="Video game music file emulators"
HOMEPAGE="http://code.google.com/p/game-music-emu/"
SRC_URI="http://game-music-emu.googlecode.com/files/${P}.tbz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-multilib.patch" )
DOCS="changes.txt design.txt gme.txt readme.txt"

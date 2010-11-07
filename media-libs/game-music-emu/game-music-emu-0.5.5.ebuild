# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/game-music-emu/game-music-emu-0.5.5.ebuild,v 1.1 2010/11/07 18:10:40 aballier Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="Video game music file emulators"
HOMEPAGE="http://code.google.com/p/game-music-emu/"
SRC_URI="http://game-music-emu.googlecode.com/files/${P}.tbz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-multilib.patch" )
DOCS="changes.txt design.txt gme.txt readme.txt"

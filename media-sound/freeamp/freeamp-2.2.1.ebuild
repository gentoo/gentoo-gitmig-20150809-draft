# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/freeamp/freeamp-2.2.1.ebuild,v 1.4 2003/09/11 01:21:31 msterret Exp $

IUSE=""

DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support -> renamed to zinf"
SRC_URI=""
HOMEPAGE="http://www.freeamp.org/"
S=${WORKDIR}/freeamp
RDEPEND=""
DEPEND="${RDEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

pkg_setup() {
	einfo "Freeamp got renamed to zinf because of legal reasons. Please emerge zinf."
	die "Package moved"
}

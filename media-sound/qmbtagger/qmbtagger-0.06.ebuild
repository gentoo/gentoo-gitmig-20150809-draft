# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmbtagger/qmbtagger-0.06.ebuild,v 1.3 2004/06/25 00:18:32 agriffis Exp $

inherit eutils

DESCRIPTION="Qt based front-end for the MusicBrainz Client Library"
HOMEPAGE="http://qmbtagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmbtagger/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"

DEPEND=">=x11-libs/qt-3.1.2
	media-libs/musicbrainz
	media-sound/madplay
	media-libs/flac
	media-libs/id3lib
	oggvorbis? ( media-sound/vorbis-tools )"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGELOG COPYING INSTALL README || die "dodoc failed"
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmbtagger/qmbtagger-0.05.ebuild,v 1.1 2004/04/08 07:15:23 eradicator Exp $

inherit eutils

DESCRIPTION="Qt based front-end for the MusicBrainz Client Library"
HOMEPAGE="http://qmbtagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmbtagger/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="LGPL-2"

DEPEND=">=x11-libs/qt-3.1.2
	media-libs/musicbrainz
	media-sound/mad
	media-libs/flac
	media-libs/id3lib
	oggvorbis? ( media-sound/vorbis-tools )"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="~x86"

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGELOG COPYING INSTALL README || die "dodoc failed"
}

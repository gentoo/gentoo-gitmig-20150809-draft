# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmbtagger/qmbtagger-0.07.ebuild,v 1.1 2004/07/02 08:11:27 fvdpol Exp $

inherit eutils

DESCRIPTION="Qt based front-end for the MusicBrainz Client Library"
HOMEPAGE="http://qmbtagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmbtagger/${P}.tar.bz2"
LICENSE="GPL-2"

DEPEND=">=x11-libs/qt-3.1.2
	media-libs/musicbrainz
	media-sound/madplay
	media-libs/flac
	media-libs/id3lib
	oggvorbis? ( media-sound/vorbis-tools )"

IUSE="oggvorbis"
SLOT="0"
KEYWORDS="~x86"


src_compile() {
	addwrite ${QTDIR}/etc/settings
	make -f admin/Makefile.common cvs || die "code setup failed"
	econf --enable-debug=full || die "configure failed"
	emake || die
}

src_install () {
	#Sandbox issues; bugs 54414 and 52497
	addpredict ${QTDIR}/etc

	make DESTDIR=${D} install || die
	dodoc CHANGELOG COPYING INSTALL README || die "dodoc failed"
}

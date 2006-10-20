# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmbtagger/qmbtagger-0.07.ebuild,v 1.9 2006/10/20 11:44:21 flameeyes Exp $

inherit eutils kde-functions

DESCRIPTION="Qt based front-end for the MusicBrainz Client Library"
HOMEPAGE="http://qmbtagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmbtagger/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="ogg debug"

DEPEND="
	=x11-libs/qt-3*
	~media-libs/flac-1.1.2
	media-libs/id3lib
	media-libs/musicbrainz
	media-libs/libmad
	ogg? ( media-sound/vorbis-tools )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-errno.patch"

	sed -i -e '/case $AUTO\(CONF\|HEADER\)_VERSION in/,+1 s/2\.5/2.[56]/g' \
		admin/cvs.sh
	emake -j1 -f admin/Makefile.common cvs || die "code setup failed"
}

src_compile() {
	econf $(use_enable debug debug full) || die "configure failed"
	emake || die "make failed"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG README || die "dodoc failed"
}

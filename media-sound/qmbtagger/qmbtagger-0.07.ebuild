# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmbtagger/qmbtagger-0.07.ebuild,v 1.11 2006/12/10 15:58:24 aballier Exp $

inherit eutils kde-functions

DESCRIPTION="Qt based front-end for the MusicBrainz Client Library"
HOMEPAGE="http://qmbtagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmbtagger/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="ogg debug"

RDEPEND="=x11-libs/qt-3*
	media-libs/flac
	media-libs/id3lib
	media-libs/musicbrainz
	media-libs/libmad
	ogg? ( media-sound/vorbis-tools )"

DEPEND="${RDEPEND}
	=sys-devel/automake-1.9*
	>=sys-devel/autoconf-2.50"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-errno.patch"
	epatch "${FILESDIR}/${P}+flac-1.1.3.patch"

	rm -rf "${S}/admin"
	ln -s "${WORKDIR}/admin" "${S}/admin"

	emake -j1 -f admin/Makefile.common || die "code setup failed"
}

src_compile() {
	econf $(use_enable debug debug full) || die "configure failed"
	emake || die "make failed"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG README || die "dodoc failed"
}

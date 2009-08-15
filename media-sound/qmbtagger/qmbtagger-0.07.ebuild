# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmbtagger/qmbtagger-0.07.ebuild,v 1.16 2009/08/15 15:14:53 ssuominen Exp $

EAPI=2
inherit eutils kde-functions

DESCRIPTION="Qt based front-end for the MusicBrainz Client Library"
HOMEPAGE="http://qmbtagger.sourceforge.net/"
SRC_URI="mirror://sourceforge/qmbtagger/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug"

RDEPEND="=x11-libs/qt-3*
	media-libs/flac[cxx]
	media-libs/id3lib
	=media-libs/musicbrainz-2*
	media-libs/libmad
	media-libs/libogg
	media-libs/libvorbis"
DEPEND="${RDEPEND}
	=sys-devel/automake-1.9*
	>=sys-devel/autoconf-2.50"

src_prepare() {
	epatch "${FILESDIR}"/${P}-errno.patch
	epatch "${FILESDIR}"/${P}+flac-1.1.3.patch
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch

	rm -rf "${S}"/admin
	ln -s "${WORKDIR}"/admin "${S}"/admin

	emake -j1 -f admin/Makefile.common || die "emake failed"
}

src_configure() {
	econf \
		$(use_enable debug debug full)
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG README || die "dodoc failed"
}

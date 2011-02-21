# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdauthor/dvdauthor-0.6.14.ebuild,v 1.4 2011/02/21 17:43:40 vapier Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Tools for generating DVD files to be played on standalone DVD players"
HOMEPAGE="http://dvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="media-libs/libdvdread
	>=media-gfx/imagemagick-5.5.7.14
	>=dev-libs/libxml2-2.6.0
	media-libs/freetype
	dev-libs/fribidi
	media-libs/libpng"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng-1.5.patch #355039
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README TODO ChangeLog
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/alg/alg-0.0.2.ebuild,v 1.1 2006/04/09 13:47:50 nattfodd Exp $

inherit perl-app

DESCRIPTION="Photo management software"
HOMEPAGE="http://home.gna.org/alg"
SRC_URI="http://download.gna.org/alg/alg-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl
		media-libs/sdl-gfx
		media-libs/sdl-image
		media-libs/sdl-ttf
		dev-perl/sdl-perl
		media-libs/exiftool
		media-gfx/imagemagick"


src_install() {
	make DESTDIR="${D}" PREFIX="/usr" SYSCONFDIR="/etc" install || die "make install failed"
}

# Copyright 2002 Gentoo Technologies, Inc.
# distributed under the terms of the GNU General Pulic License, v2.
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-1.18.5-r2.ebuild,v 1.3 2002/07/25 05:23:36 seemant Exp $

inherit perl-module

MY_P=${P/sdl-/SDL_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdlperl.org/"
SRC_URI="http://sdlperl.org/downloads/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND}
	virtual/opengl
	>=media-libs/sdl-mixer-1.0.5
	>=media-libs/sdl-image-1.0.0
	media-libs/sdl-gfx
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )"

mydoc="BUGS COPYING TODO"

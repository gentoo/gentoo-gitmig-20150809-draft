# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-1.18.5-r2.ebuild,v 1.7 2002/10/05 05:39:11 drobbins Exp $

IUSE="truetype mpeg"

inherit perl-module

MY_P=${P/sdl-/SDL_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdlperl.org/"
SRC_URI="http://sdlperl.org/downloads/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND}
	virtual/opengl
	>=media-libs/sdl-mixer-1.0.5
	>=media-libs/sdl-image-1.0.0
	media-libs/sdl-gfx
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )"

mydoc="BUGS COPYING TODO"

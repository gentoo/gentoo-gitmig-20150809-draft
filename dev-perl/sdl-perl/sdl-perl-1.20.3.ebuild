# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-1.20.3.ebuild,v 1.2 2004/12/16 17:49:50 vapier Exp $

inherit perl-module

MY_P=${P/sdl-/SDL_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdl.perl.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="truetype mpeg"

DEPEND="virtual/opengl
	>=media-libs/sdl-mixer-1.0.5
	>=media-libs/sdl-image-1.0.0
	media-libs/sdl-gfx
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )"

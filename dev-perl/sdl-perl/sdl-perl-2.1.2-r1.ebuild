# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-2.1.2-r1.ebuild,v 1.2 2005/01/31 03:54:36 mr_bones_ Exp $

style=builder
inherit perl-module

DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdl.perl.org/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DG/DGOEHRIG/SDL_Perl-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="truetype mpeg"

# Only enable this if you are confirming a bug in this module. The testsrequire
# access to your /dev/{snd,sound} devices.
#SRC_TEST="do"


style="builder"

DEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-net-1.2.4
	dev-perl/module-build
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )"

S=${WORKDIR}/SDL_Perl-${PV}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-2.2.6.ebuild,v 1.2 2009/12/16 21:24:46 maekke Exp $

EAPI=2

MODULE_AUTHOR=KTHAKORE
MY_PN=SDL_Perl
MY_P=${MY_PN}-v${PV}
inherit perl-module

DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdl.perl.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~sparc x86"
IUSE="truetype mpeg"

# Only enable this if you are confirming a bug in this module. The testsrequire
# access to your /dev/{snd,sound} devices.
#SRC_TEST="do"

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-net-1.2.4
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )
	dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	>=virtual/perl-Module-Build-0.28"

S=${WORKDIR}/${MY_P}

myconf="--extra_linker_flags='${LDFLAGS}'"

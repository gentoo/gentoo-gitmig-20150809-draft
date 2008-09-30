# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-2.1.3-r3.ebuild,v 1.9 2008/09/30 16:00:57 tove Exp $

MODULE_AUTHOR=DGOEHRIG
MY_P=SDL_Perl-${PV}
inherit perl-module eutils

DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdl.perl.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
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
	dev-perl/ExtUtils-CBuilder
	>=dev-perl/module-build-0.28"

S=${WORKDIR}/${MY_P}

PATCHES=("${FILESDIR}"/sdl-2.1.3.build.patch
	"${FILESDIR}"/sdl-perl-2.1.3-gfxPie.patch )

src_install() {
	perl-module_src_install
	# The build doesnt properly abort when there is an error
	if [[ -z $(find "${D}" -name SDL.pm) ]] ; then
		die "failed to install properly"
	fi
}

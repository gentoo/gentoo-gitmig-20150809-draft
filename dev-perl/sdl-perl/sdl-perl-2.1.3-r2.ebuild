# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-2.1.3-r2.ebuild,v 1.12 2006/10/20 20:27:36 kloeri Exp $

inherit perl-module eutils

DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdl.perl.org/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DG/DGOEHRIG/SDL_Perl-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE="truetype mpeg"

# Only enable this if you are confirming a bug in this module. The testsrequire
# access to your /dev/{snd,sound} devices.
#SRC_TEST="do"

DEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-gfx-2.0.3
	>=media-libs/sdl-net-1.2.4
	>=dev-perl/module-build-0.28
	dev-perl/ExtUtils-CBuilder
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )
	dev-lang/perl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/SDL_Perl-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	if has_version '>=dev-perl/module-build-0.28' ; then
		epatch ${FILESDIR}/sdl-2.1.3.build.patch
	fi
}

src_install() {
	perl-module_src_install
	# The build doesnt properly abort when there is an error
	if [[ -z $(find "${D}" -name SDL.pm) ]] ; then
		die "failed to install properly"
	fi
}



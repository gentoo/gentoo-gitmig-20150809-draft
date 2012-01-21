# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SDL/SDL-2.2.6.ebuild,v 1.1 2012/01/21 21:00:26 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=KTHAKORE
MY_PN=SDL_Perl
MY_P=${MY_PN}-v${PV}
inherit perl-module

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
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	>=virtual/perl-Module-Build-0.28"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# YAML is not used
	sed -i -e "/^use YAML/d" "${S}"/Build.PL || die
	perl-module_src_prepare
}

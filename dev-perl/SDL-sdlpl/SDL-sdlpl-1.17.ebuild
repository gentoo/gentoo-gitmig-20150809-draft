# Copyright 2002 Gentoo Technologies, Inc.
# distributed under the terms of the GNU General Pulic License, v2.
# Author: Defresne Sylvain (keiichi) <kamisama@free.fr>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SDL-sdlpl/SDL-sdlpl-1.17.ebuild,v 1.2 2002/05/21 18:14:08 danarmak Exp $


inherit perl-module

MY_P="SDL_perl"-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdlperl.org/"
SRC_URI="http://sdlperl.org/downloads/${MY_P}.tar.gz"

DEPEND="${DEPEND}
	virtual/opengl
	>=media-libs/sdl-mixer-1.0.5
	>=media-libs/sdl-image-1.0.0"

mydoc="BUGS COPYING TODO"

src_unpack()
{
	unpack "${A}"

	# Patch 'Makefile.PL' to use '/usr/include/SDL'
	# instead of '/usr/local/include/SDL' ...
	cp "${MY_P}/Makefile.PL" "${MY_P}/Makefile.PL.orig"
	sed 's:/usr/local/include:/usr/include:g' < "${MY_P}/Makefile.PL.orig" \
		> "${MY_P}/Makefile.PL"
	assert "Patching Makefile.PL failed !"
}

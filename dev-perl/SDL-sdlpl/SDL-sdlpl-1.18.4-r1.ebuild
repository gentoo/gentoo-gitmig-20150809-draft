# Copyright 2002 Gentoo Technologies, Inc.
# distributed under the terms of the GNU General Pulic License, v2.
# Author: Defresne Sylvain (keiichi) <kamisama@free.fr>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SDL-sdlpl/SDL-sdlpl-1.18.4-r1.ebuild,v 1.1 2002/06/05 19:55:40 seemant Exp $


inherit perl-module

MY_P="SDL_perl"-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdlperl.org/"
SRC_URI="http://sdlperl.org/downloads/${MY_P}.tar.gz"

DEPEND="${DEPEND}
	virtual/opengl
	>=media-libs/sdl-mixer-1.0.5
	>=media-libs/sdl-image-1.0.0
	mpeg? ( media-libs/smpeg )
	truetype? ( >=media-libs/sdl-ttf-2.0.5 )"

mydoc="BUGS COPYING TODO"

src_unpack()
{
	unpack "${A}"

	# Patch 'Makefile.linux' to use '/usr/include/SDL'
	# instead of '/usr/local/include/SDL' ...
	cd ${S}
	cp Makefile.linux Makefile.linux.orig
	sed -e 's:/usr/local/include/GL:/usr/lib/opengl/nvidia/include/:g' \
		-e 's:/local::g' \
		 Makefile.linux.orig > Makefile.linux

	for i in OpenGL.xs SDL_perl.xs detect.c
	do
		cp ${i} ${i}.orig
		sed "s:GL/::g" \
			${i}.orig > ${i}
	done
}

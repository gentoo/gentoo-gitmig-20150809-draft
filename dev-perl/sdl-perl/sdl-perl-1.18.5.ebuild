# Copyright 2002 Gentoo Technologies, Inc.
# distributed under the terms of the GNU General Pulic License, v2.
# $Header: /var/cvsroot/gentoo-x86/dev-perl/sdl-perl/sdl-perl-1.18.5.ebuild,v 1.1 2002/06/21 14:18:39 seemant Exp $


inherit perl-module

MY_P=${P/sdl-/SDL_}
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

SLOT=""
LICENSE="GPL-2"

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

# Copyright 2002 Gentoo Technologies, Inc.
# distributed under the terms of the GNU General Pulic License, v2.
# Author: Defresne Sylvain (keiichi) <kamisama@free.fr>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}
DESCRIPTION="SDL binding for perl"
HOMEPAGE="http://sdlperl.org/"
SRC_URI="http://sdlperl.org/${P}.tar.gz"

DEPEND="virtual/glibc
	virtual/opengl
	>=sys-devel/perl-5.6.1
	>=media-libs/sdl-mixer-1.0.5
	>=media-libs/sdl-image-1.0.0"

src_unpack()
{
	unpack "${A}"

	# Patch 'Makefile.PL' to use '/usr/include/SDL'
	# instead of '/usr/local/include/SDL' ...
	cp "${P}/Makefile.PL" "${P}/Makefile.PL.orig"
	sed 's:/usr/local/include:/usr/include:g' < "${P}/Makefile.PL.orig" > "${P}/Makefile.PL"
	assert "Patching Makefile.PL failed !"
}

src_compile ()
{
	perl Makefile.PL || die
	make || die
}

src_install ()
{
	make PREFIX="${D}/usr" INSTALLMAN3DIR="${D}/usr/share/man/man3" install || die
	dodoc BUGS COPYING README TODO
}


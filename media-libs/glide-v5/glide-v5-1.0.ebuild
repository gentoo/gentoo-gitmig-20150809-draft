# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/glide-v5/glide-v5-1.0.ebuild,v 1.2 2001/08/21 01:24:01 drobbins Exp $

S=${WORKDIR}/glide3
DESCRIPTION="the glide library (for voodoo4/5 cards)"
SRC_URI="http://www.ibiblio.org/gentoo/glide-3.20010821.tar.bz2"
HOMEPAGE="http://dri.sourceforge.net/"
DEPEND=""
RDEPEND=""

src_install () {
	insinto /usr/include/glide
	doins ${S}/*.h
	into /usr/X11R6/lib
	newlib.so ${S}/libglide3.so-voodoo45 libglide3.so
}


# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a.ebuild,v 1.1 2001/07/21 17:23:59 lamer Exp $
S=${WORKDIR}/${P}
DESCRIPTION="This is a sample skeleton ebuild file"
SRC_URI="ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz"
HOMEPAGE="http://www.trilon.com/xv/index.html"
DEPEND="virtual/x11
		  virtual/glibc
		>=media-libs/tiff-3.5.6_beta
		>=media-libs/jpeg-6b
		>=sys-libs/zlib-1.1.3"

#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
# I know very little about make but somehow I was able to riddle out how to
# fix this makefile so it not unly understood DESTDIR but makes it's own
# dirs to. I fail to understand why people can't seem to do that. Do they
# want packagers to have a hard time with thier source trees?
	patch -p1 < ${FILESDIR}/xv.diff
}

src_compile() {
	
#	try emake
	try make
}

src_install () {
	

    try make DESTDIR=${D} install
	 dodoc README INSTALL CHANGELOG BUGS IDEAS
}


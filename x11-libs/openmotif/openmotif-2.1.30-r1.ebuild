# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.1.30-r1.ebuild,v 1.3 2002/04/28 04:29:34 seemant Exp $

MY_P=${P}-4_MLI.src.tar.gz
S=${WORKDIR}/motif
DESCRIPTION="Open Motif (Metrolink Bug Fix Release)"
SRC_URI="ftp://ftp.metrolink.com/pub/openmotif/2.1.30-4/${MY_P}.tar.gz"
HOMEPAGE="http://www.metrolink.com/openmotif/"

DEPEND="virtual/glibc virtual/x11"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/site.def ${S}/config/cf/
}

src_compile() { 
													
	mkdir -p imports/x11
	cd imports/x11
	ln -s /usr/X11R6/bin bin
	ln -s /usr/X11R6/include include
	ln -s /usr/X11R6/lib lib
	cd ${S}
	make World || die
}

src_install() {															 

	make DESTDIR=${D} VARDIR=${D}/var/X11/ install || die

}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.1.30-r1.ebuild,v 1.17 2003/05/15 15:51:20 phosphan Exp $

MY_P=${P}-4_MLI.src
S=${WORKDIR}/motif
DESCRIPTION="Open Motif (Metrolink Bug Fix Release)"
SRC_URI="ftp://ftp.metrolink.com/pub/openmotif/2.1.30-4/${MY_P}.tar.gz"
HOMEPAGE="http://www.metrolink.com/openmotif/"
LICENSE="MOTIF"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha"

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

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/openmotif-2.2.2-r1.ebuild,v 1.1 2002/08/29 15:12:27 raker Exp $

S=${WORKDIR}/openMotif-2.2.2

DESCRIPTION="Open Motif"
SRC_URI="ftp://ftp.sgi.com/other/motifzone/2.2/src/openMotif-2.2.2.tar.gz"
HOMEPAGE="http://www.motifzone.org/"

LICENSE="MOTIF"
SLOT="0"
KEYWORDS="x86 ppc -sparc -sparc64"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/animate-demo.diff || die "patch failed"
	patch -p1 < ${FILESDIR}/include-order.diff || die "patch failed"
}

src_compile() { 

	./configure \
		--prefix=/usr/X11R6 \
		--sysconfdir=/etc/X11 \
		--with-x \
		--with-gnu-ld \
		--host=${CHOST} || die "configuration failed"

	make || die "make failed"
	
}

src_install() {

	make DESTDIR=${D} VARDIR=${D}/var/X11/ install || die "install failed"

}

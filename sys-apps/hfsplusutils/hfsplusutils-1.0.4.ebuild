# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hfsplusutils/hfsplusutils-1.0.4.ebuild,v 1.5 2002/07/14 19:20:18 aliz Exp $

A="hfsplus_1.0.4.src.tar.bz2"
S=${WORKDIR}/hfsplus-1.0.4
DESCRIPTION="HFS+ Filesystem Access Utilities (PPC Only)"
SRC_URI="http://ftp.penguinppc.org/users/hasi/${A}"
HOMEPAGE="http://ftp.penguinppc.org/users/hasi/"
KEYWORDS="x86"
DEPEND="sys-devel/autoconf
        sys-devel/automake
        sys-apps/bzip2"
RDEPEND=""
LICENSE="GPL"
SLOT="0"

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."
	fi
}

src_compile() {

	# This does a autoconf, automake, etc.
	emake -f Makefile.cvs all || die
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	mkdir ${D}/usr/share/man/man1
	cp doc/man/hfsp.man ${D}/usr/share/man/man1/hfsp.1
}


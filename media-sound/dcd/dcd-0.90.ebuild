# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/dcd/dcd-0.90.ebuild,v 1.8 2002/07/19 13:13:39 seemant Exp $

S=${WORKDIR}/dcd-0.90
DESCRIPTION="A simple command-line based CD Player"
HOMEPAGE="http://www.technopagan.org/dcd"
SRC_URI="http://www.technopagan.org/dcd/dcd-0.90.tar.bz2"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:PREFIX = .*$:PREFIX = \"${D}/usr\":" \
		-e "s:/man/:/share/man/:" \
		-e "s:# CDROM = /dev/cdroms/cdrom0:CDROM = \"/dev/cdroms/cdrom0\":"\
		Makefile.orig > Makefile
   
}
 
src_compile() {

	make EXTRA_CFLAGS="$CFLAGS" || die

}

src_install() {

	make PREFIX=${D}/usr install || die
	dodoc README BUGS ChangeLog

}

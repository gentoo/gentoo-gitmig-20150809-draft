# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xtrs/xtrs-4.9.ebuild,v 1.10 2004/02/20 06:02:56 mr_bones_ Exp $

DESCRIPTION="XTRS 4.9.0 - RadioShack TRS80 Emulator, inc. FreeWare ROM & LDOS Image"
HOMEPAGE="http://www.tim-mann.org/trs80.html"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
DEPEND="sys-libs/ncurses
	sys-libs/readline
	x11-base/xfree "
SRC_URI="http://home.gwi.net/~plemon/sources/xtrs-4.9.tar.gz
	 http://home.gwi.net/~plemon/support/disks/xtrs/ld4-631.tar.gz"

S=${WORKDIR}/xtrs-4.9

src_unpack () {

	### make doesn't play nicely with the usual ${PREFIX} behaviour, but relies
	### on an external Makefile.local to set compiletime options, and default
	### behavious.  we'll patch it here, to make our install sane.

	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die "XTRS Patch Failed"
}

src_compile() {

	### As we mentioned, make ignores any/all prefixes so it's just a standard
	### make here, the install prefixes were taken care of by our patch above

	emake || die "XTRS Make Failed"
}

src_install () {

	### make install, isn't really a 'make install'  but a set of 'cp x y' commands
	### which fails miserablly if the directories dont exist, we'll create them
	### first to keep everthing smiley happy

	dodir /usr/bin
	dodir /usr/share/xtrs
	dodir /usr/share/man/man1

	### and now run the make install script

	make install || die "XTRS Make Install Failed"

	### and finally, move the OSS rom images & extract an lsdos image

	cp *.hex ${D}/usr/share/xtrs
	cp *.dsk ${D}/usr/share/xtrs/disks
	tar -zxvf ${DISTDIR}/ld4-631.tar.gz -C ${D}/usr/share/xtrs/
}

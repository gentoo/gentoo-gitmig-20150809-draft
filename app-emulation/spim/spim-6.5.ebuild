# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spim/spim-6.5.ebuild,v 1.6 2004/01/06 09:21:29 mr_bones_ Exp $

DESCRIPTION="MIPS Simulator"
HOMEPAGE="http://www.cs.wisc.edu/~larus/spim.html"
# No version upstream
#SRC_URI="http://www.cs.wisc.edu/~larus/SPIM/spim.tar.gz"
SRC_URI="mirror://gentoo//${P}.tar.gz"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"

DEPEND="X? ( virtual/x11 )
	>=sys-apps/sed-4"

IUSE="X"

src_compile() {
	./Configure || die "Configure script failed"

	sed -i \
		-e 's/@make/@$(MAKE)/' \
		-e "s:\(BIN_DIR = \).*$:\1/usr/bin:" \
	    -e "s:\(MAN_DIR = \).*$:\1/usr/share/bin:" \
	    -e "s:\(TRAP_DIR = \).*$:\1/usr/sbin:" Makefile \
			|| die "sed Makefile failed"

	einfo "Making console spim"
	emake spim || die "make spim failed"
	if [ `use X` ]; then
		einfo "Making xspim"
		emake xspim || die "emake xspim failed"
	fi
}

src_install() {
	dobin spim                   || die "dobin failed"
	newman spim.man spim.1       || die "newman failed (spim)"
	if [ `use X` ]; then
		dobin xspim              || die "dobin failed"
		newman xspim.man xspim.1 || die "newman failed (xspim)"
	fi
	dosbin trap.handler          || die "dosbin failed"
	dodoc BLURB README VERSION ChangeLog Documentation/* || die "dodoc failed"
}

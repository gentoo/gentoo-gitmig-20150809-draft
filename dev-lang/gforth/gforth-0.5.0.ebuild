# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gforth/gforth-0.5.0.ebuild,v 1.2 2003/02/13 10:25:14 vapier Exp $

IUSE=""

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="GNU Forth is a fast and portable implementation of the ANS Forth language"
HOMEPAGE="http://www.gnu.org/software/gforth"
SRC_URI="http://www.complang.tuwien.ac.at/forth/gforth/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# Admittedly this should be UNSTABLE
KEYWORDS="~x86"

DEPEND="virtual/glibc"

# A lot of trouble with gcc3 and heavy opt flags, so let's try to dial
# it down to -O1 at the most.
strip-flags
export CFLAGS="${CFLAGS//-O?} -O"

src_compile() {
	econf --enable-force-reg --without-debug || die "./configure failed"
	# some configure flags that trip up gcc3.x are
	# built into the thing.  Get rid of the things.
	cp Makefile Makefile.orig
	sed -e "s:-O3::" Makefile.orig >Makefile
	cp engine/Makefile engine/Makefile.orig
	sed -e "s:-O3::" engine/Makefile.orig >engine/Makefile
	emake XCFLAGS="" ENGINE_FLAGS="" || die
}

src_install () {
	make install \
		libdir=${D}/usr/lib \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share \
		bindir=${D}/usr/bin \
		install || die
	dodoc AUTHORS README INSTALL NEWS doc/glossaries.doc gforth.ps
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.2.0.ebuild,v 1.7 2004/07/15 20:19:42 tgall Exp $

inherit eutils

MY_P="${PN}-2.2_0"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vi/ex clone"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/elvis/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha amd64 ppc64"
IUSE="X"

DEPEND=">=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"
PROVIDE="virtual/editor"

src_compile() {
	./configure \
		--prefix=/usr \
		--bindur=/usr/bin \
		--datadir=/usr/share/elvis \
		--docdir=/usr/share/doc/${PF} \
		`use_with X x` || die 'configure failed'

	# Some Makefile fixups (must happen after configure)
	# Use our CFLAGS
	sed -i -e "s:gcc -O2:gcc ${CFLAGS}:" Makefile || die 'sed 1 failed'

	# We'll install the man-pages ourselves
	sed -i -e '/^	sh instman.sh/d' Makefile || die 'sed 2 failed'

	# Don't try to write to /etc
	sed -i -e 's,/etc/elvis,${D}/etc/elvis,g' Makefile || die 'sed 3 failed'

	make || die 'make failed'
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/share/elvis
	dodir /usr/share/doc/${PF}
	dodir /etc
	make install \
		PREFIX=${D}/usr \
		BINDIR=${D}/usr/bin \
		DATADIR=${D}/usr/share/elvis \
		DOCDIR=${D}/usr/share/doc/${PF} || die 'make install failed'

	# Install the man-pages
	mv doc/elvis.man doc/elvis.1
	mv doc/elvtags.man doc/elvtags.1
	mv doc/ref.man doc/ref.1
	doman doc/*.1 || die 'doman failed'

	# Fixup some READMEs
	sed -i -e "s,${D},,g" ${D}/etc/elvis/README \
		|| die 'sed /etc/elvis/README failed'
	sed -i -e "s,${D},,g" ${D}/usr/share/elvis/README \
		|| die 'sed /usr/share/elvis/README failed'
}

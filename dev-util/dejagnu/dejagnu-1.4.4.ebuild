# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dejagnu/dejagnu-1.4.4.ebuild,v 1.2 2004/03/01 11:27:14 dholm Exp $

IUSE="doc"

S="${WORKDIR}/${P}"
DESCRIPTION="DejaGnu is a framework for testing other programs."
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/dejagnu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~ppc"

DEPEND="virtual/glibc
	dev-lang/tcl
	dev-tcltk/expect"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	use doc && dohtml -r doc/html/
}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jam/jam-2.4.ebuild,v 1.6 2003/04/27 21:38:51 vapier Exp $

inherit eutils

DESCRIPTION="Just Another Make - advanced make replacement"
SRC_URI="ftp://ftp.perforce.com/pub/jam/${P}.zip"
HOMEPAGE="http://www.perforce.com/jam/jam.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="dev-util/yacc
	app-arch/unzip"

src_compile() {
	edos2unix `find -name '*.c' -o -name '*.h'`
	# The bootstrap makefile assumes ${S} is in the path
	env PATH="${PATH}:${S}" make CFLAGS="${CFLAGS}" || die
}

src_install() {
	BINDIR="${D}/usr/bin" ./jam0 install || die
	dohtml Jam.html Jambase.html Jamfile.html
	dodoc README RELNOTES Porting
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrelltop/gkrelltop-2.2.ebuild,v 1.6 2005/03/25 16:53:52 kugelfang Exp $

DESCRIPTION="a GKrellM2 plugin which displays the top three processes"
SRC_URI="http://psychology.rutgers.edu/~zaimi/${PN}.${PV}.tgz"
HOMEPAGE="http://psychology.rutgers.edu/~zaimi/software.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ppc"

IUSE=""

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	# Unfortunately, the supplied Makefile won't work properly on
	# non-x86, so we have to do this the hard way.
	CONFIG="-DLINUX -DGKRELLM2 -fPIC `pkg-config gtk+-2.0 --cflags`"
	LIBS="`pkg-config gtk+-2.0 --libs` -shared"
	OBJS="top_three2.o gkrelltop2.o"
	gcc -c $CONFIG $CFLAGS top_three.c -o top_three2.o || die
	gcc -c $CONFIG $CFLAGS gkrelltop.c -o gkrelltop2.o || die
	gcc $LIBS $CONFIG $CFLAGS -o gkrelltop2.so $OBJS || die
}

src_install() {
	dodoc README
	insinto /usr/lib/gkrellm2/plugins
	doins gkrelltop2.so
}

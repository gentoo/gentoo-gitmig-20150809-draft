# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.2.0-r1.ebuild,v 1.9 2007/03/26 08:09:21 antarus Exp $

inherit eutils

MY_P=${P/-/}
S=${WORKDIR}/${MY_P}/unix
DESCRIPTION="A widget library for Tcl/Tk. Has been ported to Python and Perl, too."
HOMEPAGE="http://sourceforge.net/projects/tixlibrary/"
SRC_URI="mirror://sourceforge/tixlibrary/${MY_P}b1.tar.gz"
IUSE=""
LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=sys-apps/sed-4
	dev-lang/tk"

src_unpack() {
	unpack ${A}
	cd ${S}/..
	epatch "${FILESDIR}/${P}-gentoo.diff"
}

src_compile() {
	econf \
		--enable-gcc \
		--with-tcl=/usr/lib \
		--with-tk=/usr/lib \
		--enable-stubs \
		--enable-threads \
		--enable-shared || die "./configure failed"

	ebegin "Fixing the Makefile..."
	sed -e 's:TK_LIBS =:TK_LIBS = -L/usr/X11R6/lib -lX11:' \
		-e 's:^\(SHLIBS_LD_LIBS.*\):\1 ${TK_LIBS}:' \
		-i ${S}/Makefile

	eend $?
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/include
	einstall || die
}

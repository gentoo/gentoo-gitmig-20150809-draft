# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.2.0.ebuild,v 1.7 2003/05/10 19:58:11 utx Exp $

IUSE=""

MY_P=${P/-/}
S=${WORKDIR}/${MY_P}/unix
DESCRIPTION="A widget library for Tcl/Tk. Has been ported to Python and Perl, too."
HOMEPAGE="http://sourceforge.net/projects/tixlibrary/"
SRC_URI="mirror://sourceforge/tixlibrary/${MY_P}b1.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=sys-apps/portage-2.0.47-r10
	dev-lang/tk"

src_unpack() {
	unpack ${A}
	cd ${S}/..
	epatch ${FILESDIR}/${PF}-gentoo.diff || die
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
	eend $?

	make || die
}

src_install() {
	einstall || die
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp


MY_P=${P/.2002/-2002}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A library of curses widgets"
SRC_URI="ftp://invisible-island.net/cdk/${MY_P}.tgz"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
DEPEND="virtual/glibc 
	>=sys-libs/ncurses-5.2"


src_compile()
{
	econf \
		--with-ncurses \
		|| die "configure failed"

	emake || die "make failed!"
}
 

src_install()
{
	make \
		DESTDIR=${D} \
		DOCUMENT_DIR=${D}/usr/share/doc/${MY_P} install \
		|| die "make install failed"
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cdk/cdk-4.9.10.20020430.ebuild,v 1.14 2005/08/25 03:06:51 agriffis Exp $


MY_P=${P/.2002/-2002}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A library of curses widgets"
SRC_URI="ftp://invisible-island.net/cdk/${MY_P}.tgz"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha ppc sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

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

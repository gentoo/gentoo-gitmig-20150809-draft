# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="X File Explorer (Xfe) is an MS-Explorer like file manager for X. It is based on the popular, but discontinued, X Win Commander, which was developed by Maxim Baranov. Xfe aims to be the filemanager of choice for all the Unix addicts."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/xfe/"
IUSE="nls"

DEPEND="x11-libs/fox"
RDEPEND=${DEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {

	econf `use_enable nls` || die
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS FAQ README TODO NEWS
}

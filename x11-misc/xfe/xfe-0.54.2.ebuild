# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-0.54.2.ebuild,v 1.3 2003/09/05 23:29:06 msterret Exp $

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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jscalltree/jscalltree-2.3.ebuild,v 1.1 2004/04/05 19:12:09 g2boojum Exp $

MY_P=${P/js/}
DESCRIPTION="Static call tree generator for C programs"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/index.html"
SRC_URI="ftp://ftp.berlios.de/pub/calltree/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die "make failed"
}

src_install() {
	make INS_BASE=${D}/usr install || die
	dodoc README README.linux README.gmake COPYING
}

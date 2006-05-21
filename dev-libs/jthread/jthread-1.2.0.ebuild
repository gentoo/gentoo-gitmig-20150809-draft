# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jthread/jthread-1.2.0.ebuild,v 1.1 2006/05/21 14:29:59 genstef Exp $

DESCRIPTION="JThread provides some classes to make use of threads easy on different platforms."
HOMEPAGE="http://research.edm.luc.ac.be/jori/jthread/jthread.html"
SRC_URI="http://research.edm.luc.ac.be/jori/jthread/${P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README.TXT TODO ChangeLog doc/manual.tex
}

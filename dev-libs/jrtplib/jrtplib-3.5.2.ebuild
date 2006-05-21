# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jrtplib/jrtplib-3.5.2.ebuild,v 1.1 2006/05/21 14:30:29 genstef Exp $

DESCRIPTION="JRTPLIB is an object-oriented RTP library written in C++."
HOMEPAGE="http://research.edm.luc.ac.be/jori/jrtplib/jrtplib.html"
SRC_URI="http://research.edm.luc.ac.be/jori/jrtplib/${P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/jthread"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README.TXT TODO ChangeLog doc/jrtplib.tex
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jthread/jthread-1.2.1.ebuild,v 1.1 2007/12/15 15:33:36 drac Exp $

DESCRIPTION="JThread provides some classes to make use of threads easy on different platforms."
HOMEPAGE="http://research.edm.luc.ac.be/jori/jthread/jthread.html"
SRC_URI="http://research.edm.luc.ac.be/jori/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README* TODO doc/*.tex
}

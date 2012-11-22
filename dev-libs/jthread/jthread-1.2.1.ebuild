# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jthread/jthread-1.2.1.ebuild,v 1.3 2012/11/22 19:26:42 ago Exp $

DESCRIPTION="JThread provides some classes to make use of threads easy on different platforms."
HOMEPAGE="http://research.edm.uhasselt.be/~jori/page/index.php?n=CS.Jthread"
SRC_URI="http://research.edm.uhasselt.be/jori/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README* TODO doc/*.tex
}

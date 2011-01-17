# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/nestedsums/nestedsums-1.4.12.ebuild,v 1.2 2011/01/17 14:57:48 grozin Exp $
EAPI="3"
DESCRIPTION="A GiNaC-based library for symbolic expansion of certain transcendental functions"
HOMEPAGE="http://wwwthep.physik.uni-mainz.de/~stefanw/nestedsums/"
IUSE=""
SRC_URI="http://wwwthep.physik.uni-mainz.de/~stefanw/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=sci-mathematics/ginac-1.5"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	rm -f "${D}"usr/lib/*.la
	dodoc AUTHORS ChangeLog
}

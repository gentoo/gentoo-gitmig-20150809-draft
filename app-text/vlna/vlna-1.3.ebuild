# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vlna/vlna-1.3.ebuild,v 1.3 2008/09/21 13:04:31 ranger Exp $

DESCRIPTION="Add nonbreakable spaces after some prepositions in Czech texts"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"
SRC_URI="ftp://math.feld.cvut.cz/pub/olsak/vlna/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc README README.en ChangeLog vlna.txt
	insinto /usr/share/doc/${PF}
	doins vlna.dvi
}

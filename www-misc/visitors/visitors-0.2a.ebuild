# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/visitors/visitors-0.2a.ebuild,v 1.2 2004/09/03 16:15:14 pvdabeel Exp $

DESCRIPTION="Visitors - fast web log analyzer"
HOMEPAGE="http://www.hping.org/visitors/"
SRC_URI="http://www.hping.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE="debug"

DEPEND=">=media-gfx/graphviz-1.10"

S="${WORKDIR}/${P/-/_}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's:graph\.gif:graph.png:' doc.html
}

src_compile() {
	local debug=""
	use debug && debug="-g"

	emake CCOPT="${CFLAGS}" DEBUG="${debug}" || die "emake failed"
}

src_install() {
	dobin visitors
	dodoc AUTHORS COPYING Changelog README TODO
	dohtml doc.html graph.png visitors.css
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/visitors/visitors-0.7.ebuild,v 1.2 2007/10/15 06:57:37 opfer Exp $

DESCRIPTION="Fast web log analyzer"
HOMEPAGE="http://www.hping.org/visitors/"
SRC_URI="http://www.hping.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="debug"

DEPEND=""

S="${WORKDIR}/${P/-/_}"

src_unpack() {
	unpack ${A}
	cd "${S}"

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

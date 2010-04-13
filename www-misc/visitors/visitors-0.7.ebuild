# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/visitors/visitors-0.7.ebuild,v 1.4 2010/04/13 18:48:41 hwoarang Exp $

DESCRIPTION="Fast web log analyzer"
HOMEPAGE="http://www.hping.org/visitors/"
SRC_URI="http://www.hping.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
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
	dodoc AUTHORS Changelog README TODO
	dohtml doc.html visitors.css visitors.png
}

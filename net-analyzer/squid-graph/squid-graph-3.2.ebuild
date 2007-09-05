# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squid-graph/squid-graph-3.2.ebuild,v 1.1 2007/09/05 16:06:58 jokey Exp $

DESCRIPTION="Squid logfile analyzer and traffic grapher"
HOMEPAGE="http://squid-graph.sourceforge.net/"
SRC_URI="mirror://sourceforge/squid-graph/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/GD"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install () {
	dobin apacheconv generate.cgi squid-graph timeconv || die "dobin failed"
	dodoc docs
}

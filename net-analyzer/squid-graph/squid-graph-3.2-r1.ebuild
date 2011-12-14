# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squid-graph/squid-graph-3.2-r1.ebuild,v 1.2 2011/12/14 09:29:54 phajdan.jr Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Squid logfile analyzer and traffic grapher"
HOMEPAGE="http://squid-graph.sourceforge.net/"
SRC_URI="mirror://sourceforge/squid-graph/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-perl/GD[png]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install () {
	dobin apacheconv generate.cgi squid-graph timeconv || die "dobin failed"
	dodoc README
}

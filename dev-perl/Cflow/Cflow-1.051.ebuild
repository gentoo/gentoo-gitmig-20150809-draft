# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cflow/Cflow-1.051.ebuild,v 1.6 2006/06/02 13:39:49 strerror Exp $

inherit eutils

FLOW_TOOLS_VERSION="0.68"

DESCRIPTION="Provides an API for reading and analysing raw flow files"
HOMEPAGE="http://net.doit.wisc.edu/~plonka/Cflow/"
SRC_URI="http://net.doit.wisc.edu/~plonka/${PN}/${P}.tar.gz
		ftp://ftp.eng.oar.net/pub/flow-tools/flow-tools-${FLOW_TOOLS_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

PDEPEND=">=net-analyzer/flow-tools-${FLOW_TOOLS_VERSION}-r1"
RDEPEND=""

src_unpack() {
	unpack flow-tools-${FLOW_TOOLS_VERSION}.tar.gz
	cd flow-tools-${FLOW_TOOLS_VERSION}
	./configure
	make
	cd contrib
	unpack ${P}.tar.gz
}

src_install() {
	cd ${WORKDIR}/flow-tools-${FLOW_TOOLS_VERSION}/contrib/${P}
	perl Makefile.PL
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Changes README
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailgraph/mailgraph-1.11-r1.ebuild,v 1.3 2007/04/01 18:27:52 ticho Exp $

inherit eutils webapp

DESCRIPTION="A mail statistics RRDtool frontend for Postfix"
HOMEPAGE="http://people.ee.ethz.ch/~dws/software/mailgraph/"
SRC_URI="http://people.ee.ethz.ch/~dws/software/${PN}/pub/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/File-Tail
	>=net-analyzer/rrdtool-1.2.2"
DEPEND=">=sys-apps/sed-4"

pkg_setup() {
	webapp_pkg_setup
	built_with_use net-analyzer/rrdtool perl \
		|| die "net-analyzer/rrdtool must be built with USE=perl"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s|\(my \$rrd = '\).*'|\1/var/lib/mailgraph/mailgraph.rrd'|" \
		-e "s|\(my \$rrd_virus = '\).*'|\1/var/lib/mailgraph/mailgraph_virus.rrd'|" \
		mailgraph.cgi || die "sed mailgraph.cgi failed"
	epatch ${FILESDIR}/${P}-regexp.patch
}

src_install() {
	webapp_src_preinst

	# for the RRDs
	keepdir /var/lib/mailgraph

	# mailgraph daemon
	newbin mailgraph.pl mailgraph

	# mailgraph CGI script
	exeinto ${MY_CGIBINDIR}
	doexe mailgraph.cgi

	# init/conf files for mailgraph daemon
	newinitd ${FILESDIR}/mailgraph.initd mailgraph
	newconfd ${FILESDIR}/mailgraph.confd mailgraph

	# docs
	dodoc README CHANGES

	webapp_src_install
}

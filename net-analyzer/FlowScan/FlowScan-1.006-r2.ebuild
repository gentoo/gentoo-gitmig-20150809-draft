# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/FlowScan/FlowScan-1.006-r2.ebuild,v 1.2 2005/08/12 10:26:38 dholm Exp $

inherit eutils

DESCRIPTION="Program to report and analyze flow files"
HOMEPAGE="http://net.doit.wisc.edu/~plonka/FlowScan/"
SRC_URI="http://net.doit.wisc.edu/~plonka/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="|| ( app-shells/pdksh app-shells/ksh )
	dev-lang/perl
	<net-analyzer/rrdtool-1.2
	dev-perl/ConfigReader
	dev-perl/Boulder
	dev-perl/HTML-Table
	dev-perl/Net-Patricia
	dev-perl/Cflow"

DEPEND="|| ( app-shells/pdksh app-shells/ksh )
		<net-analyzer/rrdtool-1.2"

pkg_setup() {
	enewgroup flows
	enewuser flows -1 /bin/false /var/lib/flows flows
}

src_compile() {
	./configure --prefix=${D}/var/lib/flows --bindir=/var/lib/flows/bin || die "configure failed"
}

src_install() {
	make install || die "install failed"

	newinitd ${FILESDIR}/flowscan.init flowscan

	dodoc COPYING Changes INSTALL *README* TODO

	keepdir /var/lib/flows/ft
	keepdir /var/lib/flows/rrds
	keepdir /var/lib/flows/scoreboard

	sed -i 's|FlowFileGlob flows.*:*\[0-9\]|FlowFileGlob /var/lib/flows/ft-v05.*|' ${S}/cf/flowscan.cf \
		|| die "sed failed"

	exeinto /var/lib/flows/bin
	newexe ${FILESDIR}/FlowScan.pm FlowScan.pm
	insinto /var/lib/flows/bin
	doins cf/flowscan.cf cf/CampusIO.cf
}

pkg_postinst() {
	chown flows:flows /var/lib/flows/{ft,rrds,scoreboard}
	chown flows:flows /var/lib/flows/bin/flowscan.cf
	chown flows:flows /var/lib/flows/bin/FlowScan.pm
	einfo
	einfo "Please note that while you can use the reporting modules that come"
	einfo "with FlowScan, it is recommended that you install either JKFlow or"
	einfo "for more simple implementations CUFlow. Both are available in"
	einfo "Portage."
	einfo
}

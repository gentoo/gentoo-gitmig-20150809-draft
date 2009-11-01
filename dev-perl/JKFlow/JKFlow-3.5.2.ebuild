# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JKFlow/JKFlow-3.5.2.ebuild,v 1.1 2009/11/01 23:07:04 jer Exp $

inherit depend.apache eutils

MY_PN="${PN/JKF/jkf}"
MY_P="${MY_PN}-v${PV}"

DESCRIPTION="XML configurable FlowScan module for processing flows"
HOMEPAGE="http://users.telenet.be/jurgen.kobierczynski/jkflow/JKFlow.html"
SRC_URI="http://users.telenet.be/jurgen.kobierczynski/${MY_PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl
		net-analyzer/FlowScan
		dev-perl/XML-Simple
		dev-perl/Net-Patricia"
DEPEND=""

need_apache

S="${WORKDIR}/${PN}-v${PV}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i "s%my \$rrddir = \"/var/flows/reports/rrds/\";%my \$rrddir = \"/var/lib/flows/rrds/\";%" JKGrapher.pl \
		|| die "sed failed"
}

src_install() {
	exeinto /var/lib/flows/bin
	doexe JKFlow.pm
	insinto /var/lib/flows/bin
	doins JKFlow_example_routers.xml JKFlow_example_sites.xml
	exeinto /var/www/localhost/cgi-bin
	doexe JKGrapher.pl
	ewarn "JKGrapher.pl has been placed in /var/www/localhost/cgi-bin"
	ewarn "If this is not where your cgi-bin directory is then you must"
	ewarn "move it manually"

}

pkg_postinst() {
	chown flows:flows /var/lib/flows/bin/JKFlow.pm
	chown flows:flows /var/lib/flows/bin/JKFlow_example_routers.xml
	chown flows:flows /var/lib/flows/bin/JKFlow_example_sites.xml
	elog
	elog "You will need to add the following line to flowscan.cf:"
	elog "	ReportClasses JKFlow"
	elog "You must also comment out any other lines that contain"
	elog "ReportClasses."
	elog
	elog "JKFlows configuration is complex. You should review"
	elog "the two sample configuration files in /var/lib/flows/bin"
	elog "and use them as a basis for configuration for your own"
	elog "network. More information can be found at:"
	elog "http://users.telenet.be/jurgen.kobierczynski/jkflow/eindwerk.pdf"
	elog
}

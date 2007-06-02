# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CUFlow/CUFlow-1.5.ebuild,v 1.5 2007/06/02 22:15:49 jokey Exp $

inherit eutils

DESCRIPTION="Provides an API for reading and analysing raw flow files"
HOMEPAGE="http://www.columbia.edu/acis/networks/advanced/CUFlow/CUFlow.html"
SRC_URI="http://www.columbia.edu/acis/networks/advanced/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-lang/perl
		net-analyzer/FlowScan
		net-www/apache"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s%my \$rrddir = \"/cflow/reports/rrds\";%my \$rrddir = \"/var/lib/flows/rrds\";%" CUGrapher.pl \
		|| die "sed failed"
}

src_install() {
	insinto /var/lib/flows/bin
	doins ${FILESDIR}/CUFlow.cf
	exeinto /var/lib/flows/bin
	doexe CUFlow.pm
	exeinto /var/www/localhost/cgi-bin
	doexe CUGrapher.pl
	ewarn "CUGrapher.pl has been placed in /var/www/localhost/cgi-bin"
	ewarn "If this is not where your cgi-bin directory is then you must"
	ewarn "move it manually"
	dodoc README.txt

}

pkg_postinst() {
	chown flows:flows /var/lib/flows/bin/CUFlow.pm
	chown flows:flows /var/lib/flows/bin/CUFlow.cf
	elog
	elog "Edit /var/lib/flows/bin/CUFlow.cf for your site"
	elog "You will need to add the following line to flowscan.cf:"
	elog "	ReportClasses CUFlow"
	elog "You must also comment out any other lines that contain"
	elog "ReportClasses."
	elog
}

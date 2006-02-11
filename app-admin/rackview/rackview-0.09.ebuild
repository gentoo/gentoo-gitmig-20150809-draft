# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rackview/rackview-0.09.ebuild,v 1.3 2006/02/11 21:01:56 mcummings Exp $

inherit perl-module webapp

DESCRIPTION="Generate HTML page displaying computer rack layout"
HOMEPAGE="http://rackview.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/Config-Simple-4.1
		>=dev-perl/GD-1.41
		>=dev-perl/Eidetic-2
		>=virtual/perl-File-Spec-0.83
		>=virtual/perl-File-Temp-0.12"
RDEPEND=""

src_install() {
	webapp_src_preinst
	perl-module_src_install

	insinto ${MY_HTDOCSDIR}
	doins example/index.html example/top_view.png example/top_view.svg
	doins images

	insinto ${MY_CGIBINDIR}
	doins cgi-bin/*

	insinto /etc/eidetic
	doins example/example.dat

	insinto /etc/rackview
	doins etc/*

	dodoc doc/*

	webapp_src_install
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PortageXS/PortageXS-0.02.01.ebuild,v 1.3 2006/11/15 02:18:44 jer Exp $

inherit perl-module
DESCRIPTION="Portage abstraction layer for perl"
HOMEPAGE="http://download.iansview.com/gentoo/tools/PortageXS/"
SRC_URI="http://download.iansview.com/gentoo/tools/PortageXS/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl
	dev-perl/Term-ANSIColor"
RDEPEND="${DEPEND}"

pkg_preinst() {
	cp -r ${S}/etc ${D}
}

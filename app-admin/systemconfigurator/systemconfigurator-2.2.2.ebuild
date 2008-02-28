# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemconfigurator/systemconfigurator-2.2.2.ebuild,v 1.4 2008/02/28 15:31:05 nixnut Exp $

inherit eutils perl-app
DESCRIPTION="Provide a consistent API for the configuration of system related items"
HOMEPAGE="http://sisuite.org/systemconfig/"
SRC_URI="mirror://sourceforge/systemconfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-lang/perl
	dev-perl/AppConfig"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
}

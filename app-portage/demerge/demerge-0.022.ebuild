# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/demerge/demerge-0.022.ebuild,v 1.2 2007/02/19 13:17:56 dertobi123 Exp $

DESCRIPTION="demerge - revert to previous installation states"
HOMEPAGE="http://download.iansview.com/gentoo/tools/demerge/"
SRC_URI="http://download.iansview.com/gentoo/tools/demerge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/PortageXS-0.02.03
		dev-perl/Term-ANSIColor"
RDEPEND="${DEPEND}
		sys-apps/portage"

src_install() {
	dobin demerge || die
}

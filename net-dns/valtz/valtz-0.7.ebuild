# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/valtz/valtz-0.7.ebuild,v 1.2 2008/01/25 23:05:13 bangert Exp $

DESCRIPTION="Validation tool for tinydns-data zone files."
SRC_URI="http://x42.com/software/valtz/${PN}.tgz"
HOMEPAGE="http://x42.com/software/valtz/"
IUSE=""

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

RDEPEND="dev-lang/perl"

src_install() {
	dobin valtz || die
	dodoc README CHANGES
}

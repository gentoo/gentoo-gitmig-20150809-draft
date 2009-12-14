# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ParaDNS/ParaDNS-1.9.ebuild,v 1.1 2009/12/14 18:51:53 tove Exp $

EAPI=2

MODULE_AUTHOR=MSERGEANT
inherit perl-module

DESCRIPTION="a DNS lookup class for the Danga::Socket framework"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Net-DNS
	>=dev-perl/Danga-Socket-1.61"
RDEPEND="${DEPEND}"

src_prepare() {
	perl-module_src_prepare
	# kill AppleDouble encoded Macintosh file
	find "${S}" -name "._*" -delete
}

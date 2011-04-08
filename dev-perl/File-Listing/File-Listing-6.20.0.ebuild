# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Listing/File-Listing-6.20.0.ebuild,v 1.3 2011/04/08 16:09:09 maekke Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.02
inherit perl-module

DESCRIPTION="Parse directory listings"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/HTTP-Date-6.0.0
"
DEPEND="${RDEPEND}"

SRC_TEST=do

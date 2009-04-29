# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libwbxml/libwbxml-0.10.1.ebuild,v 1.3 2009/04/29 18:42:14 maekke Exp $

inherit cmake-utils

IUSE=""

DESCRIPTION="Library and tools to parse, encode and handle WBXML documents."
HOMEPAGE="http://libwbxml.opensync.org/"
SRC_URI="mirror://sourceforge/libwbxml/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND=">=dev-libs/expat-2.0.1-r1"
RDEPEND="${DEPEND}"

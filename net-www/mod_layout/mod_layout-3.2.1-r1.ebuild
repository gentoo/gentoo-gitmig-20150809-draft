# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_layout/mod_layout-3.2.1-r1.ebuild,v 1.5 2006/11/25 08:27:08 blubb Exp $

inherit apache-module

# test target in Makefile isn't sane
RESTRICT="test"

DESCRIPTION="An Apache DSO module for adding custom headers and/or footers"
HOMEPAGE="http://software.tangent.org/"
SRC_URI="http://download.tangent.org/${P}.tar.gz"

LICENSE="as-is"
SLOT="1"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

APXS1_ARGS="-c ${PN}.c utility.c origin.c layout.c"

APACHE1_MOD_CONF="${PVR}/15_mod_layout"
APACHE1_MOD_DEFINE="LAYOUT"

DOCFILES="LICENSE README THANKS TODO faq.html"

need_apache1

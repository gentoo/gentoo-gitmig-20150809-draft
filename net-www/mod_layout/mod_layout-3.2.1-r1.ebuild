# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_layout/mod_layout-3.2.1-r1.ebuild,v 1.7 2007/01/14 17:43:02 chtekk Exp $

inherit apache-module

KEYWORDS="~amd64 x86"

DESCRIPTION="An Apache1 module for adding custom headers and/or footers."
HOMEPAGE="http://software.tangent.org/"
SRC_URI="http://download.tangent.org/${P}.tar.gz"
LICENSE="as-is"
SLOT="1"
IUSE=""

DEPEND=""
RDEPEND=""

# Test target in Makefile isn't sane
RESTRICT="test"

APXS1_ARGS="-c ${PN}.c utility.c origin.c layout.c"

APACHE1_MOD_CONF="15_mod_layout"
APACHE1_MOD_DEFINE="LAYOUT"

DOCFILES="README"

need_apache1

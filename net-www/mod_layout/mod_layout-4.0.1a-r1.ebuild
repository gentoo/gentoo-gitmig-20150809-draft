# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_layout/mod_layout-4.0.1a-r1.ebuild,v 1.1 2005/01/07 19:06:56 vericgar Exp $

inherit apache-module

DESCRIPTION="An Apache2 DSO module for adding custom headers and/or footers"
HOMEPAGE="http://software.tangent.org/"

SRC_URI="http://download.tangent.org/${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="2"

APXS2_S="${S}"
APXS2_ARGS="-c ${PN}.c utility.c layout.c"

APACHE2_MOD_FILE=".libs/${PN}.so"
APACHE2_MOD_CONF="${PVR}/15_mod_layout"
APACHE2_MOD_DEFINE="LAYOUT"

DOCFILES="README"

need_apache2


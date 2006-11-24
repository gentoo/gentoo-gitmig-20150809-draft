# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_layout/mod_layout-4.0.1a-r1.ebuild,v 1.6 2006/11/24 22:05:43 beandog Exp $

inherit apache-module

DESCRIPTION="An Apache2 DSO module for adding custom headers and/or footers"
HOMEPAGE="http://software.tangent.org/"

SRC_URI="http://download.tangent.org/${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~amd64 ppc x86"
IUSE=""
SLOT="2"

APXS2_ARGS="-c ${PN}.c utility.c layout.c"

APACHE2_MOD_CONF="${PVR}/15_mod_layout"
APACHE2_MOD_DEFINE="LAYOUT"

DOCFILES="README"

need_apache2

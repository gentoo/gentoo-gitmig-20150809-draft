# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_layout/mod_layout-5.0.ebuild,v 1.1 2007/09/08 15:00:14 hollow Exp $

inherit apache-module

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="An Apache2 module for adding custom headers and/or footers."
HOMEPAGE="http://software.tangent.org/"
SRC_URI="http://download.tangent.org/${P}.tar.gz"
LICENSE="as-is"
SLOT="2"
IUSE=""

DEPEND=""
RDEPEND=""

APXS2_ARGS="-c ${PN}.c utility.c layout.c"

APACHE2_MOD_CONF="15_mod_layout"
APACHE2_MOD_DEFINE="LAYOUT"

DOCFILES="README"

need_apache2_2

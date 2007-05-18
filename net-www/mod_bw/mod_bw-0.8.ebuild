# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bw/mod_bw-0.8.ebuild,v 1.2 2007/05/18 11:30:52 chtekk Exp $

inherit apache-module

DESCRIPTION="Bandwidth Management Module for Apache2."
HOMEPAGE="http://www.ivn.cl/apache/"
SRC_URI="http://www.ivn.cl/apache/files/source/${P}.tgz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="BW"

need_apache2_2

S="${WORKDIR}/${PN}"

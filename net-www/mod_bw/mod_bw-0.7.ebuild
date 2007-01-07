# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bw/mod_bw-0.7.ebuild,v 1.1 2007/01/07 17:25:46 kloeri Exp $

inherit eutils apache-module

DESCRIPTION="Bandwidth Management Module for Apache 2.0"
HOMEPAGE="http://www.ivn.cl/apache/"
SRC_URI="http://www.ivn.cl/apache/files/source/${P}.tgz"

KEYWORDS="~amd64 ~ppc x86"
DEPEND=""
LICENSE="Apache-1.1"
SLOT="1"
IUSE=""

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="BW"

need_apache2

S=${WORKDIR}/mod_bw

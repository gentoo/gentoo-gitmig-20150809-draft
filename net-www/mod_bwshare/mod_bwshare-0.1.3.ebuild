# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bwshare/mod_bwshare-0.1.3.ebuild,v 1.4 2005/09/18 19:51:06 vericgar Exp $

inherit eutils apache-module

DESCRIPTION="bandwidth throttling and balancing for Apache 1.3.x"
HOMEPAGE="http://www.topology.org/src/bwshare/README.html"
SRC_URI="http://www.topology.org/src/bwshare/bwshare-${PV}.zip"

KEYWORDS="x86"
DEPEND="app-arch/unzip"
LICENSE="as-is"
SLOT="0"
IUSE=""

S=${WORKDIR}/src/modules/bwshare/

APACHE1_MOD_CONF="13_${PN}"
APACHE1_MOD_DEFINE="BWSHARE"

need_apache1

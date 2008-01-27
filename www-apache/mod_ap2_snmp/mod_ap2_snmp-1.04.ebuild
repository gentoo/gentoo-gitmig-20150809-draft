# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ap2_snmp/mod_ap2_snmp-1.04.ebuild,v 1.2 2008/01/27 16:16:57 hollow Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="mod_ap2_snmp allows to monitor the Apache Web Server by SNMP"
HOMEPAGE="http://mod-apache-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/mod-apache-snmp/${P/-/_}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="net-analyzer/net-snmp"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c ${PN}.c -lnetsnmp -lcrypto -ldl"
APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="SNMP"

need_apache2

S="${WORKDIR}"/${P/-/_}

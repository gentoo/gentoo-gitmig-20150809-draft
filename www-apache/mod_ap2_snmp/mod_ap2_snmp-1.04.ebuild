# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ap2_snmp/mod_ap2_snmp-1.04.ebuild,v 1.1 2007/09/09 08:09:25 hollow Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="mod_lisp2 is an Apache2 module to easily write web applications in Common Lisp."
HOMEPAGE="http://www.fractalconcept.com/asp/sdataQIceRsMvtN9fDM==/sdataQuvY9x3g$ecX"
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

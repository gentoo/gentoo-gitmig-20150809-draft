# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_extract_forwarded/mod_extract_forwarded-2.0.2.ebuild,v 1.1 2007/12/31 23:58:35 hollow Exp $

inherit apache-module

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Apache module that rewrites X-Forwarded-For to REMOTE_ADDR for reverse proxy configurations."
HOMEPAGE="http://www.openinfo.co.uk/apache/index.html"
SRC_URI="http://www.openinfo.co.uk/apache/extract_forwarded-${PV}.tar.gz"
LICENSE="Apache-2.0 Apache-1.1"
SLOT="0"

DEPEND=""
RDEPEND=""

APXS2_S="${WORKDIR}/extract_forwarded"
APXS2_ARGS="-c ${PN}.c"

APACHE2_MOD_CONF="98_${PN}"
APACHE2_MOD_DEFINE="EXTRACT_FORWARDED"

need_apache2

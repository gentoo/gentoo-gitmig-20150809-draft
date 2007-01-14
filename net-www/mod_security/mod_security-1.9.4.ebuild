# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_security/mod_security-1.9.4.ebuild,v 1.2 2007/01/14 20:09:54 chtekk Exp $

inherit apache-module

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

DESCRIPTION="Intrusion Detection System for Apache."
HOMEPAGE="http://www.modsecurity.org/"
SRC_URI="http://www.modsecurity.org/download/${P/mod_security-/modsecurity-apache_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

S="${WORKDIR}/${P/mod_security-/modsecurity-apache_}"

APXS1_ARGS="-S LIBEXECDIR=${S} -c ${S}/apache1/mod_security.c"
APACHE1_MOD_FILE="apache1/${PN}.so"
APACHE1_MOD_CONF="99_mod_security"
APACHE1_MOD_DEFINE="SECURITY"

APXS2_ARGS="-S LIBEXECDIR=${S} -c ${S}/apache2/mod_security.c"
APACHE2_MOD_FILE="apache2/.libs/${PN}.so"
APACHE2_MOD_CONF="99_mod_security"
APACHE2_MOD_DEFINE="SECURITY"

DOCFILES="CHANGES httpd.conf.* INSTALL LICENSE README"
use doc && DOCFILES="${DOCFILES} doc/modsecurity-apache-manual-1.9.pdf"

need_apache

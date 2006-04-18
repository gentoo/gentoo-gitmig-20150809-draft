# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_security/mod_security-1.8.7.ebuild,v 1.6 2006/04/18 23:07:50 weeve Exp $

inherit eutils apache-module

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Intrusion Detection System for apache"
HOMEPAGE="http://www.modsecurity.org"
SRC_URI="http://www.modsecurity.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc"

APXS1_ARGS="-S LIBEXECDIR=${S} -c ${S}/apache1/mod_security.c"
APACHE1_MOD_FILE="apache1/${PN}.so"
APACHE1_MOD_CONF="1.8.6/99_mod_security"
APACHE1_MOD_DEFINE="SECURITY"

APXS2_ARGS="-S LIBEXECDIR=${S} -c ${S}/apache2/mod_security.c"
APACHE2_MOD_FILE="apache2/.libs/${PN}.so"
APACHE2_MOD_CONF="1.8.6/99_mod_security"
APACHE2_MOD_DEFINE="SECURITY"

DOCFILES="CHANGES httpd.conf.* INSTALL LICENSE README"
useq doc && DOCFILES="${DOCFILES} modsecurity-manual.pdf"

need_apache

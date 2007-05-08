# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_security/mod_security-2.1.1.ebuild,v 1.3 2007/05/08 14:46:04 armin76 Exp $

inherit apache-module

KEYWORDS="~amd64 ~mips ppc ~sparc x86"

MY_P=${P/mod_security-/modsecurity-apache_}

DESCRIPTION="Web application firewall and Intrusion Detection System for Apache."
HOMEPAGE="http://www.modsecurity.org/"
SRC_URI="http://www.modsecurity.org/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

APXS2_ARGS="-S LIBEXECDIR=${S} -c -o ${PN}2.so ${S}/apache2/*.c"
APACHE2_MOD_FILE=".libs/${PN}2.so"
#APACHE2_MOD_CONF="99_mod_security"
APACHE2_MOD_DEFINE="SECURITY"

need_apache2

src_install() {
	apache2_src_install

	# install documentation
	dodoc CHANGES
	newdoc rules/CHANGELOG CHANGES.crs
	newdoc rules/README README.crs
	dohtml doc/*.html doc/*.gif doc/*.jpg doc/*.css doc/*.pdf
	cp -r "${S}"/doc/html-multipage "${D}"/usr/share/doc/${P}/html/

	# Once APACHE2_MOD_CONF is able to use newconfd (probably never), this line
	# should go.
	insinto ${APACHE2_MODULES_CONFDIR}
	newins "${FILESDIR}"/99_mod_security-${PV}.conf 99_mod_security.conf

	# Prepare the core ruleset
	for i in $( ls "${S}"/rules/*.conf ); do
		mv $i ${i/modsecurity_crs_/}
	done

	# Install core ruleset
	insinto ${APACHE2_MODULES_CONFDIR}/mod_security/
	doins "${S}"/rules/*.conf
}

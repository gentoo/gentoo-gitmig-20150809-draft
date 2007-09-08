# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_security/mod_security-2.1.2.ebuild,v 1.1 2007/09/08 08:10:52 hollow Exp $

inherit apache-module

MY_P=${P/mod_security-/modsecurity-apache_}

DESCRIPTION="Web application firewall and Intrusion Detection System for Apache."
HOMEPAGE="http://www.modsecurity.org/"
SRC_URI="http://www.modsecurity.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

APXS2_ARGS="-DWITH_LIBXML2 -I/usr/include/libxml2 -lxml2 -S LIBEXECDIR=${S} -c -o ${PN}2.so ${S}/apache2/*.c"
APACHE2_MOD_FILE=".libs/${PN}2.so"
APACHE2_MOD_CONF="${PVR}/99_mod_security"
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

	# Prepare the core ruleset
	sed -i -e 's:logs/:/var/log/apache2/:g' "${S}"/rules/*.conf
	for i in "${S}"/rules/*.conf; do
		mv $i ${i/modsecurity_crs_/}
	done

	# Install core ruleset
	insinto ${APACHE2_MODULES_CONFDIR}/mod_security/
	doins "${S}"/rules/*.conf
}

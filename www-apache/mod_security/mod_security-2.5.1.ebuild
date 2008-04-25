# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_security/mod_security-2.5.1.ebuild,v 1.2 2008/04/25 11:20:28 hollow Exp $

inherit apache-module

MY_P=${P/mod_security-/modsecurity-apache_}
MY_P=${MY_P/_rc/-rc}

DESCRIPTION="Web application firewall and Intrusion Detection System for Apache."
HOMEPAGE="http://www.modsecurity.org/"
SRC_URI="http://www.modsecurity.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="lua"

DEPEND="dev-libs/libxml2
	lua? ( >=dev-lang/lua-5.1 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

APACHE2_MOD_FILE="apache2/.libs/${PN}2.so"
APACHE2_MOD_CONF="2.1.2/99_mod_security"
APACHE2_MOD_DEFINE="SECURITY"

need_apache2

src_compile() {
	cd apache2

	econf --with-apxs="${APXS}" \
		--without-curl \
		$(use_with lua) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	apache-module_src_install

	# install rules updater
	newbin tools/rules-updater.pl rules-updater

	# install documentation
	dodoc CHANGES
	newdoc rules/CHANGELOG CHANGES.crs
	newdoc rules/README README.crs
	dohtml doc/*.html doc/*.gif doc/*.jpg doc/*.css doc/*.pdf
	insinto /usr/share/doc/${P}/html/
	doins -r doc/html-multipage

	# Prepare the core ruleset
	sed -i -e 's:logs/:/var/log/apache2/:g' "${S}"/rules/*.conf
	for i in "${S}"/rules/*.conf; do
		mv $i ${i/modsecurity_crs_/}
	done

	# Install core ruleset
	insinto ${APACHE_MODULES_CONFDIR}/mod_security/
	doins "${S}"/rules/*.conf
}

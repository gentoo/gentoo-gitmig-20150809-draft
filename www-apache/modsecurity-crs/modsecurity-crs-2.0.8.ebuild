# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/modsecurity-crs/modsecurity-crs-2.0.8.ebuild,v 1.1 2010/09/24 13:01:25 flameeyes Exp $

EAPI=2

DESCRIPTION="Core Rule Set for ModSecurity"
HOMEPAGE="http://www.owasp.org/index.php/Category:OWASP_ModSecurity_Core_Rule_Set_Project"
SRC_URI="mirror://sourceforge/mod-security/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="vanilla"

RDEPEND=">=www-apache/mod_security-2.5.12-r1"
DEPEND=""

S="${WORKDIR}/${PN}_${PV}"

RULESDIR=/etc/apache2/modules.d/mod_security

src_install() {
	insinto "${RULESDIR}" || die
	doins *.conf base_rules/* || die

	insinto "${RULESDIR}"/optional_rules
	doins optional_rules/* || die

	# These are not conditionals because they actually need to be
	# moved for the rules to work — bug #329131
	mv "${D}${RULESDIR}"/modsecurity_{46_et_sql_injection,46_et_web_rules,42_comment_spam}.data \
		"${D}${RULESDIR}"/optional_rules || die

	if ! use vanilla; then
		mv "${D}${RULESDIR}"/modsecurity_*{41_phpids,50_outbound}* \
			"${D}${RULESDIR}"/optional_rules || die
	fi

	dodoc CHANGELOG README || die
}

pkg_postinst() {
	if ! use vanilla; then
		elog "Please note that the Core Rule Set is quite draconic; to make it more usable,"
		elog "the Gentoo distribution disables a few rule set files, that are relevant for"
		elog "PHP-only websites or that would make it kill a website that discussed of source code."
		elog
		elog "Furthermore we disable the 'HTTP Parameter Pollution' tests that disallow"
		elog "multiple parameters with the same name, because that's common practice both"
		elog "for Rails-based web-applications and Bugzilla."
	else
		elog "You decided to enable the original Core Rule Set from ModSecurity."
		elog "Be warned that the original Core Rule Set is draconic and most likely will"
		elog "render your web application unusable if you don't disable at leat some of"
		elog "the rules."
	fi
	elog
	elog "If you want to enable further rules, check the following directory:"
	elog "	${APACHE_MODULES_CONFDIR}/mod_security/optional_rules"
}

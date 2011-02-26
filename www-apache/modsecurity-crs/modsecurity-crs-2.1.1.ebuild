# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/modsecurity-crs/modsecurity-crs-2.1.1.ebuild,v 1.2 2011/02/26 14:44:55 xarthisius Exp $

EAPI=2

DESCRIPTION="Core Rule Set for ModSecurity"
HOMEPAGE="http://www.owasp.org/index.php/Category:OWASP_ModSecurity_Core_Rule_Set_Project"
SRC_URI="mirror://sourceforge/mod-security/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="vanilla"

RDEPEND=">=www-apache/mod_security-2.5.12-r1"
DEPEND=""

S="${WORKDIR}/${PN}_${PV}"

RULESDIR=/etc/apache2/modules.d/mod_security

src_install() {
	insinto "${RULESDIR}" || die
	doins base_rules/* || die

	# these are considered examples, but we install them anyway, and let
	# etc-update deal with them.
	for file in *.conf.example; do
		newins "${file}" "${file%.example}" || die "failed to install ${file}"
	done

	insinto "${RULESDIR}"/optional_rules
	doins optional_rules/* || die

	insinto "${RULESDIR}"/experimental_rules
	doins experimental_rules/* || die

	if ! use vanilla; then
		mv "${D}${RULESDIR}"/modsecurity_*50_outbound* \
			"${D}${RULESDIR}"/optional_rules || die
	fi

	dodoc CHANGELOG README || die
}

pkg_postinst() {
	if ! use vanilla; then
		elog "Please note that the Core Rule Set is quite draconic; to make it more usable,"
		elog "the Gentoo distribution disables a few rule set files, that are relevant for"
		elog "PHP-only websites or that would make it kill a website that discussed of source code."
	else
		elog "You decided to enable the original Core Rule Set from ModSecurity."
		elog "Be warned that the original Core Rule Set is draconic and most likely will"
		elog "render your web application unusable if you don't disable at leat some of"
		elog "the rules."
	fi
	elog
	elog "If you want to enable further rules, check the following directories:"
	elog "	${APACHE_MODULES_CONFDIR}/mod_security/optional_rules"
	elog "	${APACHE_MODULES_CONFDIR}/mod_security/experimental_rules"
	elog ""
	elog "Starting from version 2.0.9, the default for the Core Rule Set is again to block"
	elog "when rules hit. If you wish to go back to the 2.0.8 method of anomaly scoring, you"
	elog "should change modsecurity_crs_10_config.conf so that you have these settings enabled:"
	elog ""
	elog "    #SecDefaultAction \"phase:2,deny,log\""
	elog "    SecAction \"phase:1,t:none,nolog,pass,setvar:tx.anomaly_score_blocking=on\""
	elog ""
}

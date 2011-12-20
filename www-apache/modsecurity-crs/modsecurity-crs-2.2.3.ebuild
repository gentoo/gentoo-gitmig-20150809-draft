# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/modsecurity-crs/modsecurity-crs-2.2.3.ebuild,v 1.1 2011/12/20 11:14:05 flameeyes Exp $

EAPI=4

DESCRIPTION="Core Rule Set for ModSecurity"
HOMEPAGE="http://www.owasp.org/index.php/Category:OWASP_ModSecurity_Core_Rule_Set_Project"
SRC_URI="mirror://sourceforge/mod-security/${PN}_${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=www-apache/mod_security-2.5.13-r1"
DEPEND=""

S="${WORKDIR}/${PN}_${PV}"

RULESDIR=/etc/modsecurity

src_install() {
	insinto "${RULESDIR}"/base_rules
	doins base_rules/*

	insinto "${RULESDIR}"/optional_rules
	doins optional_rules/*

	insinto "${RULESDIR}"/experimental_rules
	doins experimental_rules/*

	dodoc CHANGELOG README

	(
		cat - <<EOF
<IfDefine SECURITY>
EOF

		cat modsecurity_crs_10_config.conf.example

		cat - <<EOF

Include /etc/modsecurity/base_rules/*.conf

# Optionally use the other rules as well
# Include /etc/modsecurity/optional_rules/*.conf
# Include /etc/modsecurity/experimental_rules/*.conf
</IfDefine>

# -*- apache -*-
# vim: ts=4 filetype=apache

EOF
	) > "${T}"/"80_${PN}.conf"

	insinto /etc/apache2/modules.d/
	doins "${T}"/"80_${PN}.conf"
}

pkg_postinst() {
	elog
	elog "If you want to enable further rules, check the following directories:"
	elog "	${RULESDIR}/optional_rules"
	elog "	${RULESDIR}/experimental_rules"
	elog ""
	elog "Starting from version 2.0.9, the default for the Core Rule Set is again to block"
	elog "when rules hit. If you wish to go back to the 2.0.8 method of anomaly scoring, you"
	elog "should change 80_${PN}.conf so that you have these settings enabled:"
	elog ""
	elog "    #SecDefaultAction \"phase:2,deny,log\""
	elog "    SecAction \"phase:1,t:none,nolog,pass,setvar:tx.anomaly_score_blocking=on\""
	elog ""
	elog "Starting from version 2.1.2 rules are installed, for consistency, under"
	elog "/etc/modsecurity, and can be configured with the following file:"
	elog "  /etc/apache2/modules.d/80_${PN}.conf"
	elog ""
}

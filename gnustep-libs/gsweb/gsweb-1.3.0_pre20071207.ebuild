# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gsweb/gsweb-1.3.0_pre20071207.ebuild,v 1.1 2007/12/08 19:51:56 voyageur Exp $

inherit gnustep-2 apache-module

DESCRIPTION="GNUstepWeb: a library compatible with WebObjects 4.x"
HOMEPAGE="http://www.gnustep.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="gnustep-libs/gdl2
	x11-libs/libPropList"
RDEPEND="${DEPEND}"
need_apache2

APACHE2_MOD_FILE="${S}/GSWAdaptors/Apache2/.libs/mod_gsw.so"
APACHE2_MOD_CONF="42_mod_gsweb"

src_compile() {
	gnustep-base_src_compile
	cd GSWAdaptors/Apache2
	gnustep-base_src_compile
}

src_install() {
	gnustep-base_src_install
	cd GSWAdaptors/Apache2
	apache-module_src_install

	insinto /etc/gsweb
	doins "${FILESDIR}"/gsweb.conf

	if use doc; then
		insinto ${GNUSTEP_SYSTEM_DOC}/GSWeb
		doins "${S}"/GSWAdaptors/Doc/ConfigurationFile.html
	fi
}

pkg_postinst() {
	elog "To enable ${PN}, you need to edit your /etc/conf.d/apache2 file and"
	elog "add \"-D GSWeb\" to APACHE2_OPTS"
	elog "Configuration file was installed as"
	elog "    ${APACHE2_MODULES_CONFDIR}/${APACHE2_MOD_CONF}"
}

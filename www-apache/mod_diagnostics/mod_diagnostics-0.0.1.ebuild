# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_diagnostics/mod_diagnostics-0.0.1.ebuild,v 1.2 2005/02/25 12:07:21 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO which can do debugging of modules in the Apache2 Filter Chain"
HOMEPAGE="http://apache.webthing.com/mod_diagnostics"
SRC_URI="http://apache.webthing.com/${PN}/${PN}.c"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

S=${WORKDIR}

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="DIAGNOSTICS"

need_apache2

src_unpack() {
	cp ${DISTDIR}/${PN}.c . || die
}

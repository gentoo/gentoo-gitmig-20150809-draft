# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_diagnostics/mod_diagnostics-0.0.1.ebuild,v 1.4 2006/01/16 06:29:14 chriswhite Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO which can do debugging of modules in the Apache2 Filter Chain"
HOMEPAGE="http://apache.webthing.com/mod_diagnostics"
SRC_URI="mirror://gentoo/${P}.c"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

S=${WORKDIR}

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="DIAGNOSTICS"

need_apache2

src_unpack() {
	cp ${DISTDIR}/${P}.c ${PN}.c || die
}

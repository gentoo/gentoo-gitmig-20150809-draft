# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_csv/mod_csv-0.0.1.ebuild,v 1.2 2005/02/25 12:03:24 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO which translates CSV files to HTML on the fly"
HOMEPAGE="http://apache.webthing.com/mod_csv"
SRC_URI="http://apache.webthing.com/${PN}/${PN}.c"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="CSV"

need_apache2

src_unpack() {
	cp ${DISTDIR}/${PN}.c . || die
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_vdbh/mod_vdbh-1.0.3-r1.ebuild,v 1.4 2006/01/18 07:01:22 chriswhite Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO for mass virtual hosting using a MySQL database"
HOMEPAGE="http://www.synthemesc.com/mod_vdbh/"
SRC_URI="http://www.synthemesc.com/downloads/${PN}/${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=dev-db/mysql-3.23
	>=sys-libs/zlib-1.1.4"

APXS2_ARGS="-DHAVE_STDDEF_H -I/usr/include/mysql -Wl,-lmysqlclient -c ${PN}.c"
APACHE2_MOD_CONF="${PVR}/21_mod_vdbh"
APACHE2_MOD_DEFINE="VDBH"

DOCFILES="AUTHORS README TODO"

need_apache2

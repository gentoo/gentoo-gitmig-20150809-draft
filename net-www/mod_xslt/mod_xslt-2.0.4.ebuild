# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_xslt/mod_xslt-2.0.4.ebuild,v 1.7 2005/08/24 02:42:14 hparker Exp $

inherit eutils apache-module

DESCRIPTION="An xslt filtering DSO module for Apache2"
HOMEPAGE="http://www.mod-xslt.com/"
SRC_URI="mirror://sourceforge/mod-xslt/${PN}.${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

RDEPEND="dev-libs/libxslt
		 dev-libs/libxml2"

DEPEND="${RDEPEND}
		dev-lang/perl"

S="${WORKDIR}/${PN}.${PV}"
BASE_CONFIG_PV="1.0.5a-r1"

APXS2_ARGS="-I/usr/include/libxml2 -lxslt -lxml2 -lpthread -lz -lm -c ${PN}.c"

APACHE2_MOD_CONF="${BASE_CONFIG_PV}/25_mod_xslt"
APACHE2_MOD_DEFINE="XSLT"

DOCFILES="ChangeLog.txt README.txt"

need_apache2

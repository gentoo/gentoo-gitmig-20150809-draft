# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_xslt/mod_xslt-2.0.4.ebuild,v 1.12 2007/01/14 21:36:04 chtekk Exp $

inherit apache-module

KEYWORDS="amd64 ppc x86"

DESCRIPTION="An XSLT filtering module for Apache2."
HOMEPAGE="http://www.mod-xslt.com/"
SRC_URI="mirror://sourceforge/mod-xslt/${PN}.${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/libxslt
		dev-libs/libxml2"

DEPEND="${RDEPEND}
		dev-lang/perl"

S="${WORKDIR}/${PN}.${PV}"

APXS2_ARGS="-I/usr/include/libxml2 -lxslt -lxml2 -lpthread -lz -lm -c ${PN}.c"

APACHE2_MOD_CONF="25_${PN}"
APACHE2_MOD_DEFINE="XSLT"

DOCFILES="ChangeLog.txt README.txt"

need_apache2

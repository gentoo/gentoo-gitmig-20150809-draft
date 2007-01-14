# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.22-r1.ebuild,v 1.8 2007/01/14 17:17:44 chtekk Exp $

inherit apache-module

KEYWORDS="amd64 ppc x86"

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted."
HOMEPAGE="http://dominia.org/djao/limitipconn2.html"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
LICENSE="as-is"
SLOT="2"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="test"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="LIMITIPCONN INFO"

DOCFILES="ChangeLog README"

need_apache2

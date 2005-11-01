# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.22-r1.ebuild,v 1.5 2005/11/01 19:21:22 dertobi123 Exp $

inherit eutils apache-module
RESTRICT="test"

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn2.html"

KEYWORDS="ppc x86"
SLOT="2"
LICENSE="as-is"
IUSE=""

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="LIMITIPCONN"

DOCFILES="ChangeLog INSTALL README"

need_apache2

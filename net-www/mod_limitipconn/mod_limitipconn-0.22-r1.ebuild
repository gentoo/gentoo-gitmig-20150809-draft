# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.22-r1.ebuild,v 1.7 2006/10/28 11:56:00 tomk Exp $

inherit eutils apache-module
RESTRICT="test"

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted."
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn2.html"

KEYWORDS="amd64 ppc x86"
SLOT="2"
LICENSE="as-is"
IUSE=""

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="LIMITIPCONN INFO"

DOCFILES="ChangeLog INSTALL README"

need_apache2

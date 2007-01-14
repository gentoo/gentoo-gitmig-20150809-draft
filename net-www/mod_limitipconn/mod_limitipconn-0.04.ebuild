# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.04.ebuild,v 1.5 2007/01/14 17:17:44 chtekk Exp $

inherit eutils apache-module

KEYWORDS="amd64 ~ppc ~x86"

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted."
HOMEPAGE="http://dominia.org/djao/limitipconn.html"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
LICENSE="as-is"
SLOT="1"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE1_MOD_CONF="27_${PN}"
APACHE1_MOD_DEFINE="LIMITIPCONN INFO"

DOCFILES="ChangeLog README"

need_apache1

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-local_ip.patch"
	epatch "${FILESDIR}/${P}-vhost.patch"
}

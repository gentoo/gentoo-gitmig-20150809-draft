# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_limitipconn/mod_limitipconn-0.22-r1.ebuild,v 1.1 2005/01/09 00:29:55 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Allows administrators to limit the number of simultaneous downloads permitted"
SRC_URI="http://dominia.org/djao/limit/${P}.tar.gz"
HOMEPAGE="http://dominia.org/djao/limitipconn.html"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="as-is"
IUSE=""
APXS2_S="${S}"
APXS2_ARGS="-c mod_limitipconn.c"
DOCFILES="ChangeLog INSTALL README"
APACHE2_MOD_CONF="27_mod_limitipconn"

need_apache2

src_compile() {
	apache2_src_compile
}

src_install() {
	apache2_src_install
}


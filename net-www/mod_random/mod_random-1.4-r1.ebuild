# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_random/mod_random-1.4-r1.ebuild,v 1.1 2005/01/07 19:33:21 vericgar Exp $

inherit apache-module

DESCRIPTION="An Apache DSO providing custom randomized responses"
HOMEPAGE="http://software.tangent.org/"
SRC_URI="http://download.tangent.org/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""
SLOT="1"

DEPEND=""
RDEPEND=""

APXS1_S="${S}"

APACHE1_MOD_FILE="${PN}.so"
APACHE1_MOD_CONF="${PVR}/17_mod_random"
APACHE1_MOD_DEFINE="RANDOM"

DOCFILES="ChangeLog LICENSE README TODO faq.html"

need_apache1

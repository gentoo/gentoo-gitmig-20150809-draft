# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_random/mod_random-2.0-r1.ebuild,v 1.1 2005/01/07 19:33:21 vericgar Exp $

inherit apache-module

DESCRIPTION="An Apache2 DSO providing custom randomized responses"
HOMEPAGE="http://software.tangent.org/"

SRC_URI="http://download.tangent.org/${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""
SLOT="2"

DEPEND=""
RDEPEND=""

APXS2_S="${S}"

APACHE2_MOD_FILE=".libs/${PN}.so"
APACHE2_MOD_CONF="${PVR}/17_mod_random"
APACHE2_MOD_DEFINE="RANDOM"

DOCFILES="ChangeLog LICENSE README faq.html"

need_apache2


# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_macro/mod_macro-1.1.2.ebuild,v 1.3 2007/01/15 17:14:35 chtekk Exp $

inherit apache-module

KEYWORDS="~x86"

DESCRIPTION="An Apache1 module providing macros for the Apache config file."
HOMEPAGE="http://www.coelho.net/mod_macro/"
SRC_URI="http://www.coelho.net/${PN}/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE1_MOD_CONF="27_${PN}"
APACHE1_MOD_DEFINE="MACRO"

DOCFILES="CHANGES INSTALL README mod_macro.html"

need_apache1

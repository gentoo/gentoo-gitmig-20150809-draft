# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_macro/mod_macro-1.1.2.ebuild,v 1.1 2005/03/02 06:50:55 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An Apache DSO providing macros for the apache config file"
HOMEPAGE="http://www.coelho.net/mod_macro/"
SRC_URI="http://www.coelho.net/mod_macro/${P}.tar.bz2"

LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

APACHE1_MOD_CONF="27_${PN}"
APACHE1_MOD_DEFINE="MACRO"

DOCFILES="CHANGES INSTALL README mod_macro.html"

need_apache1


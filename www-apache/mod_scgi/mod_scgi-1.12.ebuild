# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_scgi/mod_scgi-1.12.ebuild,v 1.2 2007/08/27 16:50:02 angelos Exp $

inherit apache-module

DESCRIPTION="Apache module for a replacement of the CGI protocol, similar to FastCGI."
HOMEPAGE="http://python.ca/scgi/"
SRC_URI="http://quixote.python.ca/releases/${P/mod_}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="www-apps/scgi"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/mod_}"

APXS2_S="${S}/apache2"
APACHE2_MOD_FILE="${S}/apache2/.libs/${PN}.so"
APACHE2_MOD_CONF="20_mod_scgi"
APACHE2_MOD_DEFINE="SCGI"

DOCFILES="PKG-INFO LICENSE.txt CHANGES apache2/README"

need_apache

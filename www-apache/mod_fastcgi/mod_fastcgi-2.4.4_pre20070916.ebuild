# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fastcgi/mod_fastcgi-2.4.4_pre20070916.ebuild,v 1.1 2007/09/16 12:20:18 hollow Exp $

inherit apache-module

DESCRIPTION="FastCGI is a language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs."
HOMEPAGE="http://fastcgi.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="FastCGI"

S="${WORKDIR}"/${PN}

APXS2_ARGS="-c mod_fastcgi.c fcgi*.c"
APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FASTCGI"

DOCFILES="CHANGES README docs/LICENSE.TERMS docs/mod_fastcgi.html"

need_apache

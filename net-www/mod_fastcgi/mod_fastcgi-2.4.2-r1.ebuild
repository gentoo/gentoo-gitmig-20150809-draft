# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_fastcgi/mod_fastcgi-2.4.2-r1.ebuild,v 1.3 2005/03/23 13:39:09 fmccor Exp $

inherit eutils apache-module

DESCRIPTION="FastCGI  is a language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs."
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
SLOT="0"
HOMEPAGE="http://fastcgi.com/"
SRC_URI="http://fastcgi.com/dist/${P}.tar.gz"
LICENSE="Apache-1.1"

APXS1_ARGS="-c mod_fastcgi.c fcgi*.c"
APXS2_ARGS="${APXS1_ARGS}"

APACHE1_MOD_CONF="${PVR}/20_mod_fastcgi"
APACHE2_MOD_CONF="${PVR}/20_mod_fastcgi"

APACHE1_MOD_DEFINE="FASTCGI"
APACHE2_MOD_DEFINE="FASTCGI"

DOCFILES="CHANGES README docs/LICENSE.TERMS docs/mod_fastcgi.html"

need_apache

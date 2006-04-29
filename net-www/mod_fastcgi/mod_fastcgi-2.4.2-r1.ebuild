# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_fastcgi/mod_fastcgi-2.4.2-r1.ebuild,v 1.8 2006/04/29 00:32:56 weeve Exp $

inherit eutils apache-module

DESCRIPTION="FastCGI  is a language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs."
KEYWORDS="amd64 ppc sparc x86"
SLOT="0"
HOMEPAGE="http://fastcgi.com/"
SRC_URI="http://fastcgi.com/dist/${P}.tar.gz"
LICENSE="mod_fastcgi"

APXS1_ARGS="-c mod_fastcgi.c fcgi*.c"
APXS2_ARGS="${APXS1_ARGS}"

APACHE1_MOD_CONF="${PVR}/20_mod_fastcgi"
APACHE2_MOD_CONF="${PVR}/20_mod_fastcgi"

APACHE1_MOD_DEFINE="FASTCGI"
APACHE2_MOD_DEFINE="FASTCGI"

DOCFILES="CHANGES README docs/LICENSE.TERMS docs/mod_fastcgi.html"

need_apache

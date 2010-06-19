# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fastcgi_handler/mod_fastcgi_handler-0.2.ebuild,v 1.1 2010/06/19 17:08:51 hollow Exp $

inherit apache-module

DESCRIPTION="A simple FastCGI handler module"
HOMEPAGE="http://bb.xnull.de/projects/mod_fastcgi_handler/"
SRC_URI="http://bb.xnull.de/projects/mod_fastcgi_handler/dist/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FASTCGI_HANDLER"

APXS2_ARGS="-o ${PN}.so -c *.c"

need_apache2

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_common_redirect/mod_common_redirect-0.1.ebuild,v 1.2 2009/09/17 10:36:45 hollow Exp $

inherit apache-module

DESCRIPTION="mod_common_redirect implements common redirects without mod_rewrite overhead"
HOMEPAGE="http://bb.xnull.de/projects/mod_common_redirect/"
SRC_URI="http://bb.xnull.de/projects/mod_common_redirect/dist/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="COMMON_REDIRECT"

need_apache2

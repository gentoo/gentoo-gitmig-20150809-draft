# Copyright 1999-2003 Gentoo Technologies, Inc.
# Released under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-php/jpgraph/jpgraph-1.12.2.ebuild,v 1.1 2003/08/04 00:33:41 stuart Exp $
#
# Based on the ebuild submitted by ??

DESCRIPTION="JpGraph is a fully OO graph drawing library for PHP."
HOMEPAGE="http://www.aditus.nu/jpgraph/"
SRC_URI="http://www.aditus.nu/jpgraph/downloads/${P}.tar.gz"

# QPL license for non-commercial use, regular commercial license available
LICENSE="QPL-1.0"

IUSE="truetype"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND="virtual/php
	     >=media-libs/libgd-1.8"

S="${WORKDIR}/${P}"
JPGRAPH_CACHE_DIR="/var/cache/jpgraph"

inherit php-lib

# setup defaults in case we don't have a web server installed

HTTPD_USER=root
HTTPD_GROUP=root

has_version "net-www/apache" && inherit webapp-apache

src_install ()
{
	sed -i 's|DEFINE("CACHE_FILE_GROUP", "wwwadmin");|DEFINE("CACHE_FILE_GROUP", "${HTTPD_GROUP}";|' src/jpgraph.php
	sed -i 's|/tmp/jpgraph_cache/|${JPGRAPH_CACHE_DIR}/|g' src/jpgraph.php

	sed -i 's|DEFINE("USE_CACHE",false);|if (!defined("USE_CACHE")) DEFINE("USE_CACHE", false);|' src/jpgraph.php

	# install php files
	php-lib_src_install src `cd src ; find . -type f -print`

	# install documentation
	dodoc README src/Changelog
	dohtml -r docs/*

	# setup the cache dir
	# cachedir must be world-writable, because PHP/CLI doesn't run
	# as the apache user!

	keepdir "${JPGRAPH_CACHE_DIR}"
	fowners ${HTTPD_USER}.${HTTPD_GROUP} "${JPGRAPH_CACHE_DIR}"
	fperms 777 "${JPGRAPH_CACHE_DIR}"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/jpgraph/jpgraph-2.1.1.ebuild,v 1.2 2006/04/21 23:23:18 tcort Exp $

inherit php-lib-r1

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
DESCRIPTION="Fully OO graph drawing library for PHP."
HOMEPAGE="http://www.aditus.nu/jpgraph/"
LICENSE="QPL-1.0"
SLOT="0"
IUSE="truetype"

MY_P=${P/_/}
SRC_URI="http://members.chello.se/jpgraph/jpgdownloads/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

RDEPEND="${RDEPEND}
		truetype? ( media-fonts/corefonts )"

need_php_by_category

JPGRAPH_CACHE_DIR="/var/cache/jpgraph"
COREFONTS_DIR="/usr/share/fonts/corefonts"

pkg_setup() {
	has_php

	# we need the GD functionality of PHP
	require_gd

	# check to wich user:group the cache dir will go
	if has_version "net-www/apache" ; then
		HTTPD_USER="apache"
		HTTPD_GROUP="apache"
		einfo "Configuring cache dir ${JPGRAPH_CACHE_DIR} for Apache."
	else
		HTTPD_USER="root"
		HTTPD_GROUP="root"
		ewarn "No Apache webserver detected - ${JPGRAPH_CACHE_DIR} will be"
		ewarn "owned by ${HTTPD_USER}:${HTTPD_GROUP} instead."
	fi
}

src_install() {
	# some patches to adapt the config to Gentoo
	einfo "Patching jpg-config.inc.php"

	# patch 1:
	# make jpgraph use the correct group for file permissions

	sed -i "s|^DEFINE(\"CACHE_FILE_GROUP\",\"wwwadmin\");|DEFINE(\"CACHE_FILE_GROUP\",\"${HTTPD_GROUP}\");|" src/jpg-config.inc.php

	# patch 2:
	# make jpgraph use the correct directory for caching

	sed -i "s|.*DEFINE(\"CACHE_DIR\",\"/tmp/jpgraph_cache/\");|DEFINE(\"CACHE_DIR\",\"${JPGRAPH_CACHE_DIR}/\");|" src/jpg-config.inc.php

	# patch 3:
	# make jpgraph use the correct directory for the corefonts if the truetype USE flag is set

	if use truetype ; then
		sed -i "s|.*DEFINE(\"TTF_DIR\",\"/usr/X11R6/lib/X11/fonts/truetype/\");|DEFINE(\"TTF_DIR\",\"${COREFONTS_DIR}/\");|" src/jpg-config.inc.php
	fi

	# patch 4:
	# disable READ_CACHE in jpgraph

	sed -i "s|^DEFINE(\"READ_CACHE\",true);|DEFINE(\"READ_CACHE\",false);|" src/jpg-config.inc.php

	# install php files
	einfo "Building list of files to install"
	php-lib-r1_src_install src `cd src ; find . -type f -print`

	# install documentation
	einfo "Installing documentation"
	dodoc-php README QPL.txt
	dohtml -r docs/*

	# setup the cache dir
	# cachedir must be world-writable, because PHP/CLI doesn't run
	# as the apache user!
	einfo "Setting up the cache dir"
	keepdir "${JPGRAPH_CACHE_DIR}"
	fowners ${HTTPD_USER}:${HTTPD_GROUP} "${JPGRAPH_CACHE_DIR}"
	fperms 700 "${JPGRAPH_CACHE_DIR}"
}

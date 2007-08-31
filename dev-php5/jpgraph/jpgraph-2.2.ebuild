# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/jpgraph/jpgraph-2.2.ebuild,v 1.1 2007/08/31 09:38:43 jokey Exp $

inherit php-lib-r1 eutils

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DESCRIPTION="Fully OO graph drawing library for PHP."
HOMEPAGE="http://www.aditus.nu/jpgraph/"
SRC_URI="http://hem.bredband.net/jpgraph2/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
IUSE="truetype"

DEPEND=""
RDEPEND="truetype? ( media-fonts/corefonts )"

need_php_by_category

[[ -z "${JPGRAPH_CACHEDIR}" ]] && JPGRAPH_CACHEDIR="/var/cache/jpgraph-php5/"

pkg_setup() {
	has_php

	# we need the PHP GD functionality
	require_gd

	# check to wich user:group the cache dir will go
	if has_version "www-servers/apache" ; then
		HTTPD_USER="apache"
		HTTPD_GROUP="apache"
		einfo "Configuring ${JPGRAPH_CACHEDIR} for Apache."
	else
		HTTPD_USER="${HTTPD_USER:-root}"
		HTTPD_GROUP="${HTTPD_GROUP:-root}"
		ewarn "No Apache webserver detected - ${JPGRAPH_CACHEDIR} will be"
		ewarn "owned by ${HTTPD_USER}:${HTTPD_GROUP} instead."
		ewarn "It this is not what you want, you can define"
		ewarn "HTTPD_USER and HTTPD_GROUP variables and re-emerge ${PN}."
		epause 3
	fi
}

src_install() {
	# some patches to adapt the config to Gentoo
	einfo "Patching jpg-config.inc.php"

	# patch 1:
	# make jpgraph use the correct group for file permissions

	sed -i "s|^DEFINE(\"CACHE_FILE_GROUP\",\"wwwadmin\");|DEFINE(\"CACHE_FILE_GROUP\",\"${HTTPD_GROUP}\");|" src/jpg-config.inc.php \
		|| die "sed failed in patch 1"

	# patch 2:
	# make jpgraph use the correct directory for caching

	sed -i "s|.*DEFINE(\"CACHE_DIR\",\"/tmp/jpgraph_cache/\");|DEFINE(\"CACHE_DIR\",\"${JPGRAPH_CACHEDIR}\");|" src/jpg-config.inc.php \
		|| die "sed failed in patch 2"

	# patch 3:
	# make jpgraph use the correct directory for the corefonts if the truetype USE flag is set

	if use truetype ; then
		sed -i "s|.*DEFINE(\"TTF_DIR\",\"/usr/X11R6/lib/X11/fonts/truetype/\");|DEFINE(\"TTF_DIR\",\"/usr/share/fonts/corefonts/\");|" src/jpg-config.inc.php \
			|| die "sed failed in patch 3"
	fi

	# patch 4:
	# disable READ_CACHE in jpgraph

	sed -i "s|^DEFINE(\"READ_CACHE\",true);|DEFINE(\"READ_CACHE\",false);|" src/jpg-config.inc.php \
		|| die "sed failed in patch 4"

	# install php files
	einfo "Building list of files to install"
	php-lib-r1_src_install src `cd src ; find . -type f -print`

	# install documentation
	einfo "Installing documentation"
	dodoc-php README QPL.txt
	insinto /usr/share/doc/${CATEGORY}/${PF}
	doins -r docs/*

	# setup the cache dir
	einfo "Setting up the cache dir"
	keepdir "${JPGRAPH_CACHEDIR}"
	fowners ${HTTPD_USER}:${HTTPD_GROUP} "${JPGRAPH_CACHEDIR}"
	fperms 750 "${JPGRAPH_CACHEDIR}"
}

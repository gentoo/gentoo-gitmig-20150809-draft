# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fastcgi_handler/mod_fastcgi_handler-0.4.ebuild,v 1.1 2010/12/11 18:51:39 hollow Exp $

EAPI="3"

GITHUB_AUTHOR="hollow"
GITHUB_PROJECT="mod_fastcgi_handler"
GITHUB_COMMIT="8973a51"

inherit apache-module

DESCRIPTION="A simple FastCGI handler module"
HOMEPAGE="http://github.com/hollow/mod_fastcgi_handler"
SRC_URI="http://nodeload.github.com/${GITHUB_AUTHOR}/${GITHUB_PROJECT}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${GITHUB_AUTHOR}-${GITHUB_PROJECT}-${GITHUB_COMMIT}

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FASTCGI_HANDLER"

APXS2_ARGS="-o ${PN}.so -c *.c"

need_apache2

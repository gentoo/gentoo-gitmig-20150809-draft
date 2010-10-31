# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-mongo/pecl-mongo-1.0.10.ebuild,v 1.1 2010/10/31 19:02:54 olemarkus Exp $

EAPI=3

PHP_EXT_NAME="mongo"

inherit php-ext-pecl-r2

DESCRIPTION="MongoDB database driver"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

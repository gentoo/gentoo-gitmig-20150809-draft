# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-uploadprogress/pecl-uploadprogress-1.0.1.ebuild,v 1.1 2010/04/26 20:45:46 beandog Exp $

inherit php-ext-pecl-r1

DESCRIPTION="An extension to track progress of a file upload."
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

need_php_by_category

pkg_postinst() {
	elog "This extension is only known to work on Apache with mod_php."
}

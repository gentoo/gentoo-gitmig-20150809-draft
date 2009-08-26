# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Sigma/PEAR-HTML_Template_Sigma-1.2.0.ebuild,v 1.1 2009/08/26 21:00:56 beandog Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="An implementation of Integrated Templates API with template 'compilation' added"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use ctype
}

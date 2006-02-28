# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Sigma/PEAR-HTML_Template_Sigma-1.1.4.ebuild,v 1.11 2006/02/28 09:09:40 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="An implementation of Integrated Templates API with template 'compilation' added"
LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

pkg_setup() {
	require_php_with_use ctype
}

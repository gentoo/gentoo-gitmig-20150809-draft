# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-4.2.3.ebuild,v 1.8 2004/08/02 03:37:35 tgall Exp $

S=${WORKDIR}
DESCRIPTION="HTML documentation for PHP"
SRC_URI="mirror://gentoo/php_manual_en-4.2.3.tar.bz2"
HOMEPAGE="http://www.php.net/download-docs.php"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ppc64"
IUSE=""

src_install() {
	dohtml *
}

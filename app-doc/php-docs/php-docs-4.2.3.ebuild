# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-4.2.3.ebuild,v 1.5 2003/09/05 01:44:11 msterret Exp $

S=${WORKDIR}
DESCRIPTION="HTML documentation for PHP"
SRC_URI="mirror://gentoo/php_manual_en-4.2.3.tar.bz2"
HOMEPAGE="http://www.php.net/download-docs.php"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

src_install() {
	dohtml *
}

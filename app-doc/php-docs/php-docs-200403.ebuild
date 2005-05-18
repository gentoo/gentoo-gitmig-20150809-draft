# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-200403.ebuild,v 1.7 2005/05/18 07:05:09 corsair Exp $

# if you update this ebuild, you *must* also update the php-2.eclass to
# depend on the new manual

DESCRIPTION="HTML documentation for PHP"
HOMEPAGE="http://www.php.net/download-docs.php"
SRC_URI="mirror://gentoo/php_manual_en-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_install() {
	dohtml *
}

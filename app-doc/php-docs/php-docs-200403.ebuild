# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-200403.ebuild,v 1.2 2004/03/29 10:43:31 robbat2 Exp $

# if you update this ebuild, you *must* also update the php-2.eclass to
# depend on the new manual

S=${WORKDIR}
DESCRIPTION="HTML documentation for PHP"
SRC_URI="mirror://gentoo/php_manual_en-${PV}.tar.gz"
HOMEPAGE="http://www.php.net/download-docs.php"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa ia64 amd64 mips"
IUSE=""

src_install() {
	dohtml *
}

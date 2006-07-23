# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/cphplib/cphplib-0.51.ebuild,v 1.1 2006/07/23 20:57:25 chtekk Exp $

inherit php-lib-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Cute PHP Library (cphplib)."
HOMEPAGE="http://cphplib.sourceforge.net/"
SRC_URI="mirror://sourceforge/cphplib/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=">=dev-php/PEAR-DB-1.7.6-r1"
RDEPEND="${DEPEND}"

need_php_by_category

src_install() {
	# install php files
	php-lib-r1_src_install . *.spec
	php-lib-r1_src_install . *.inc

	# install documentation
	dodoc-php ChangeLog COPYRIGHT LGPL README TODO
}

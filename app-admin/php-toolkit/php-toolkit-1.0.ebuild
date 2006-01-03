# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/php-toolkit/php-toolkit-1.0.ebuild,v 1.5 2006/01/03 20:09:28 corsair Exp $

inherit eutils

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
DESCRIPTION="Utilities for managing installed copies of PHP ."
HOMEPAGE="http://svn.gnqs.org/projects/gentoo-php-overlay/wiki/PhpToolkit"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="!app-admin/eselect-php"

src_install() {
	# install php-select
	dosbin "${FILESDIR}/php-select"

	dodir /usr/share/php-select
	insinto /usr/share/php-select
	doins "${FILESDIR}/php-select-modules/libapache.sh"
	doins "${FILESDIR}/php-select-modules/libsymlink.sh"
	doins "${FILESDIR}/php-select-modules/apache1.sh"
	doins "${FILESDIR}/php-select-modules/apache2.sh"
	doins "${FILESDIR}/php-select-modules/php.sh"
	doins "${FILESDIR}/php-select-modules/php-cgi.sh"
	doins "${FILESDIR}/php-select-modules/php-devel.sh"
}

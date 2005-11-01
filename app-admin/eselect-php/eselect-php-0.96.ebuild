# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-php/eselect-php-0.96.ebuild,v 1.5 2005/11/01 23:55:26 vapier Exp $

inherit eutils

DESCRIPTION="PHP modules for eselect."
HOMEPAGE="http://svn.gnqs.org/projects/gentoo-php-overlay/wiki/InstallPhpEselectModules"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
IUSE=""
DEPEND="app-admin/eselect"

src_install() {
	dodir /usr/share/eselect/modules
	insinto /usr/share/eselect/modules
	doins ${FILESDIR}/php.eselect
	doins ${FILESDIR}/php-cgi.eselect
	doins ${FILESDIR}/php-devel.eselect
}

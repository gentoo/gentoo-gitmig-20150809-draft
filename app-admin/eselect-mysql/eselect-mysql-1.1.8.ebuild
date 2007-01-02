# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-mysql/eselect-mysql-1.1.8.ebuild,v 1.1 2007/01/02 11:37:13 vivo Exp $

DESCRIPTION="Utility to change the default MySQL server being used"
HOMEPAGE="http://www.gentoo.org/"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="app-admin/eselect"

src_install() {
	pushd "${FILESDIR}" 1>/dev/null
	insinto /usr/share/eselect/modules
	doins mysql.eselect
	popd 1>/dev/null
}

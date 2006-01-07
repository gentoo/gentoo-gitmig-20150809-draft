# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-mysql/eselect-mysql-1.0.0.ebuild,v 1.1 2006/01/07 14:22:20 vivo Exp $

DESCRIPTION="Utility to change the default MySQL server being used"
HOMEPAGE="http://www.gentoo.org/"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0_rc1"

src_install() {
	pushd "${FILESDIR}" 1>/dev/null
	insinto /usr/share/eselect/modules
	doins mysql.eselect
	popd 1>/dev/null
}

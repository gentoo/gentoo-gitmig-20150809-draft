# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lafilefixer/lafilefixer-0.0.1.ebuild,v 1.3 2009/04/26 15:38:18 armin76 Exp $

EAPI=2

DESCRIPTION="Utility to fix your .la files"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~s390 ~sh ~sparc ~x86"
IUSE=""
DEPEND=""
RDEPEND=">=app-shells/bash-3.1
	sys-apps/grep
	sys-apps/coreutils
	sys-apps/sed"

S=""

src_unpack() { : ; }
src_prepare() { : ; }
src_configure() { : ; }
src_unpack() { : ; }
src_install() {	newbin "${FILESDIR}/${P}" ${PN} ; }

pkg_postinst() {
	elog "This simple utility will fix your .la files to not point to other .la files."
	elog "This is desirable because it will ensure your packages are not broken when"
	elog ".la files are removed from other packages."
	elog "The utility is for now quite simple and only accepts a delimited list of"
	elog ".la files."
	elog ""
	elog "Patches are accepted."
	elog ""
	elog "If you want to fix all your .la files, something like this will work:"
	elog 'lafilefixer $(find /usr/lib* -name '*.la' -type f)'
	elog "NOTE: If you have kde installed, you may want to add /usr/kde/*/lib* to the"
	elog "list of directories to search for .la files:"
	elog 'lafilefixer $(find /usr/lib* /usr/kde/*/lib* -name '*.la' -type f)'
	elog ""
	elog "Verify that all your .la files are fixed with revdep-rebuild from"
	elog "app-portage/gentoolkit"
}

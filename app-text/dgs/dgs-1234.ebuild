# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-1234.ebuild,v 1.1 2005/09/15 04:38:29 vapier Exp $

DESCRIPTION="fake ebuild to force removal of broken path_dps.m4"
HOMEPAGE="http://ronaldmcnightrider.ytmnd.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_postinst() {
	echo
	ewarn "This is a fake ebuild to force removal of a broken"
	ewarn "m4 file installed by earlier dps packages."
	echo
	ewarn "For more info: http://bugs.gentoo.org/98762"
	echo

	if [[ -e ${ROOT}/usr/share/aclocal/path_dps.m4 ]] ; then
		ewarn "You should probably delete this yourself:"
		ewarn " /usr/share/aclocal/path_dps.m4"
		echo
	fi

	ewarn "Now that we've faked it, please unmerge me:"
	ewarn "emerge -C dgs"
	die "Please unmerge me: emerge -C dgs"
}

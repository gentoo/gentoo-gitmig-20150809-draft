# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-ximian/openoffice-ximian-1.9.199.ebuild,v 1.4 2006/01/17 19:00:31 gustavoz Exp $

IUSE=""

DESCRIPTION="Ximian-ized version of OpenOffice.org, a full office productivity suite - now deprecated"
HOMEPAGE="http://go-oo.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {

	ewarn
	ewarn " This package is now deprecated, please use app-office/openoffice "
	ewarn " instead, which - starting from 2.0 - comes with all the extra stuff that "
	ewarn " was previously only available in openoffice-ximian."
	ewarn
	ewarn " To do this you will have to unmerge openoffice-ximian first. If you "
	ewarn " want to have a backup just for the case that something goes wrong "
	ewarn " during the build process of app-office/openoffice, do: "
	ewarn
	ewarn " # quickpkg openoffice-ximian"
	ewarn
	ewarn " which builds a binary package. In case of a failure and that you fast "
	ewarn " need a working version of OOo you can get the old version back "
	ewarn " by issueing: "
	ewarn
	ewarn " # emerge -k =app-office/openoffice-ximian-1.3.9-r1 "
	ewarn
	ewarn " (Assuming the last version you used was 1.3.9-r1, if not just replace "
	ewarn " the number) "

	die
}

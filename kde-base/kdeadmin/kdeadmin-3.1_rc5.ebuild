# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.1_rc5.ebuild,v 1.4 2002/12/26 00:41:46 bjb Exp $
inherit kde-dist 

IUSE="pam"
DESCRIPTION="KDE administration tools (user manager, etc.)"
PATCHES="${FILESDIR}/${P}-gentoo.diff"
KEYWORDS="x86 ppc sparc alpha"
PATCHES="${FILESDIR}/${PN}-qt311-gentoo.diff"

newdepend ">=app-arch/rpm-4.0.4-r1
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"
myconf="$myconf --without-rpm"

# TODO: add nis support

# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.1_rc6.ebuild,v 1.1 2003/01/05 13:09:43 hannes Exp $
inherit kde-dist 

IUSE="pam"
DESCRIPTION="KDE administration tools (user manager, etc.)"
PATCHES="${FILESDIR}/${P}-gentoo.diff"
KEYWORDS="~x86 ~sparc"

newdepend ">=app-arch/rpm-4.0.4-r1
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"
myconf="$myconf --without-rpm"

# TODO: add nis support

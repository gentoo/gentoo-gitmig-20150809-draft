# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.1.ebuild,v 1.4 2003/02/01 18:50:52 jmorgan Exp $
inherit kde-dist 

IUSE="pam"
DESCRIPTION="KDE administration tools (user manager, etc.)"

KEYWORDS="x86 ppc ~sparc"

newdepend ">=app-arch/rpm-4.0.4-r1
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"
myconf="$myconf --without-rpm"

# TODO: add nis support

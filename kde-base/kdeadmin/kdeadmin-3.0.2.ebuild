# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.0.2.ebuild,v 1.5 2002/08/01 19:38:30 gerk Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - administration tools"

KEYWORDS="x86 ppc"

newdepend ">=app-arch/rpm-4.0.4-r1
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"
myconf="$myconf --with-rpm"


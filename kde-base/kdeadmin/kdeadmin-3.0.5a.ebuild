# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.0.5a.ebuild,v 1.4 2003/02/01 18:50:52 jmorgan Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - administration tools"

KEYWORDS="x86 ~ppc ~alpha sparc"
PATCHES="${FILESDIR}/${PN}-qt311-gentoo.diff"

newdepend ">=app-arch/rpm-4.0.4-r1
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"
myconf="$myconf --with-rpm"


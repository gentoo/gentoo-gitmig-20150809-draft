# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-2.2.2.ebuild,v 1.9 2002/08/14 13:08:53 murphy Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - administration tools"

KEYWORDS="x86 sparc sparc64"

newdepend ">=app-arch/rpm-3.0.5
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

src_compile() {

	kde_src_compile myconf

    	use pam		&& myconf="$myconf --with-pam"		|| myconf="$myconf --without-pam"

	kde_src_compile configure make

}




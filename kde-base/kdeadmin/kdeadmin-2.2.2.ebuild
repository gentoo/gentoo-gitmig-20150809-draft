# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-2.2.2.ebuild,v 1.5 2002/05/21 18:14:08 danarmak Exp $

inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Administration"

newdepend ">=app-arch/rpm-3.0.5
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

src_compile() {

	kde_src_compile myconf

    	use pam		&& myconf="$myconf --with-pam"		|| myconf="$myconf --without-pam"

	kde_src_compile configure make

}




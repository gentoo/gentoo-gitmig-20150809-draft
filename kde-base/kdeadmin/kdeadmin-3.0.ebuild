# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.0.ebuild,v 1.2 2002/05/10 12:07:56 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist

DESCRIPTION="${DESCRIPTION}Administration"

newdepend ">=app-arch/rpm-3.0.5
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"
myconf="$myconf --with-rpm"


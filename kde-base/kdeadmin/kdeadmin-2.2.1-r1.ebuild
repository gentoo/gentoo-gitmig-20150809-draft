# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-2.2.1-r1.ebuild,v 1.2 2001/10/01 11:04:22 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Administration"

NEWDEPEND=">=app-arch/rpm-3.0.5
	pam? ( >=sys-libs/pam-0.72 )"

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"

src_compile() {

	kde_src_compile myconf

    	use pam		&& myconf="--with-pam"		|| myconf="--without-pam"

	kde_src_compile configure make

}




# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.0.5b.ebuild,v 1.3 2003/07/16 16:28:32 pvdabeel Exp $
inherit kde-dist

IUSE="pam"
DESCRIPTION="KDE $PV - administration tools"
KEYWORDS="x86 ppc ~alpha sparc"
PATCHES="${FILESDIR}/${PN}-qt311-gentoo.diff"

newdepend "dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )"
	# >=app-arch/rpm-4.0.4-r1"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"

# Doesn't compile with the new rpm 4.2. I don't suppose this'll ever be fixed in the 3.0.x tree,
# and it's not for gentoo ppl to fix rpm problems really :-) so disabling this. --danarmak 20030315
myconf="$myconf --without-rpm"




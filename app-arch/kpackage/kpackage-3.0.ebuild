# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/kpackage/kpackage-3.0.ebuild,v 1.3 2002/07/11 06:30:10 drobbins Exp $


PARENT="kde-base/kdeadmin/kdeadmin-3.0-r1.ebuild"
inherit kde-child

DESCRIPTION="kdeadmin - kpackage: frontend for managing rpms, debs etc."

newdepend ">=app-arch/rpm-3.0.5"
myconf="$myconf --with-rpm"

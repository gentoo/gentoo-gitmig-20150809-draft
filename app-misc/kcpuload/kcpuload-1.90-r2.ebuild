# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/kcpuload/kcpuload-1.90-r2.ebuild,v 1.1 2001/10/03 22:20:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="A CPU applet for KDE2"
SRC_URI="http://kde.quakenet.eu.org/files/${P}.tar.gz"
HOMEPAGE="http://kde.quakenet.eu.org/kcpuload.shtml"

DEPEND="$DEPEND >=kde-base/kdelibs-2.1.1"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.1.1"

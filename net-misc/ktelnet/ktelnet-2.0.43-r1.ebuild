# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ktelnet/ktelnet-2.0.43-r1.ebuild,v 1.1 2001/10/03 22:20:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="A Putty like for KDE"
SRC_URI="http://www.spaghetti-code.de/download/ktelnet/${PN}2-0.43.tgz"
HOMEPAGE="http://www.spaghetti-code.de/software/linux/ktelnet/"

DEPEND="$DEPEND >=kde-base/kdelibs-2.1.1"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.1.1"

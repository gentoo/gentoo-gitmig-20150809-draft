# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kstars/kstars-0.6-r1.ebuild,v 1.1 2001/10/03 22:20:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="A fun and educational desktop planetarium program for KDE2"
HOMEPAGE="http://kstars.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"

DEPEND="$DEPEND >=kde-base/kdelibs-2.1"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.1"

src_install () {
    # ugh. hopefully the authors next release will be fixed.
    patch -p0 < ${FILESDIR}/destdir-icons.diff || die "bad patchfile"
	kde_src_install
}

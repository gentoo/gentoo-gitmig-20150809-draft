# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# Maintainer Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kstars/kstars-0.6-r1.ebuild,v 1.4 2002/02/20 08:59:41 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1

DESCRIPTION="A fun and educational desktop planetarium program for KDE2"
HOMEPAGE="http://kstars.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"

src_install () {
    # ugh. hopefully the authors next release will be fixed.
    patch -p0 < ${FILESDIR}/destdir-icons.diff || die "bad patchfile"
	kde_src_install
}

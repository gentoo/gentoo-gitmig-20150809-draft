# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/kstars/kstars-0.6-r2.ebuild,v 1.2 2002/05/04 19:29:58 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1

DESCRIPTION="A fun and educational desktop planetarium program for KDE2"
HOMEPAGE="http://kstars.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

src_install () {
	# ugh. hopefully the authors next release will be fixed.
	patch -p0 < ${FILESDIR}/destdir-icons.diff || die "bad patchfile"
	kde_src_install
}

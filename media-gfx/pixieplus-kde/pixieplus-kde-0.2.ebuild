# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixieplus-kde/pixieplus-kde-0.2.ebuild,v 1.1 2002/01/04 19:08:24 g2boojum Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.2
S=${WORKDIR}/${P}
DESCRIPTION="Mosfet's KDE image/photo viewer, editor, and manager"
SRC_URI="http://www.mosfet.org/pixie/${P}.tar.gz"
HOMEPAGE="http://www.mosfet.org/pixie"

newdepend ">=kde-base/kdebase-2.1"


src_compile() {
	make -f Makefile.cvs || die "make -f Makefile.cvs failed"
	kde_src_compile
}


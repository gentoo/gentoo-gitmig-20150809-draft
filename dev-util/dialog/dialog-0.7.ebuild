# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialog/dialog-0.7.ebuild,v 1.4 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Tool to display Dialog boxes from Shell"
SRC_URI="http://www.advancedresearch.org/dialog/${A}"
HOMEPAGE="http://www.advancedresearch.org/dialog/"

DEPEND=">=sys-apps/bash-2.04-r3
	>=sys-libs/ncurses-5.2"

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README 
}


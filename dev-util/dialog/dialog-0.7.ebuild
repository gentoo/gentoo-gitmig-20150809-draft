# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialog/dialog-0.7.ebuild,v 1.6 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Tool to display Dialog boxes from Shell"
SRC_URI="http://www.advancedresearch.org/dialog/${P}.tar.gz"
HOMEPAGE="http://www.advancedresearch.org/dialog/"

DEPEND=">=sys-apps/bash-2.04-r3
	>=sys-libs/ncurses-5.2"

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README 
}

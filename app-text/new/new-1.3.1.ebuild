# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/new/new-1.3.1.ebuild,v 1.4 2003/07/11 20:35:25 aliz Exp $

DESCRIPTION="New is a template system, especially useful in conjunction with a simple text editor such as vi."
SRC_URI="http://www.flyn.org/projects/new/${P}.tar.gz"
HOMEPAGE="http://www.flyn.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

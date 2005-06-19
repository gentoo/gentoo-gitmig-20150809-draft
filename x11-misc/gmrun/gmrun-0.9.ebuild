# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gmrun/gmrun-0.9.ebuild,v 1.7 2005/06/19 19:36:55 smithj Exp $

IUSE=""
DESCRIPTION="A GTK-2 based launcher box with bash style auto completion!"
SRC_URI="mirror://sourceforge/gmrun/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gmrun"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/gtk+-2.2.0"

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

pkg_postinst(){
	echo
	einfo "Gmrun now featers a ~/.gmrunrc see /usr/share/gmrun/gmrunrc for help"
	echo
}

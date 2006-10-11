# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gmrun/gmrun-0.9.2.ebuild,v 1.11 2006/10/11 11:20:16 nelchael Exp $

IUSE=""
DESCRIPTION="A GTK-2 based launcher box with bash style auto completion!"
SRC_URI="mirror://sourceforge/gmrun/${P}.tar.gz"
HOMEPAGE="http://www.bazon.net/mishoo/gmrun.epl"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="x86 amd64 ppc ~sparc"

DEPEND=">=x11-libs/gtk+-2.2.0
		dev-libs/popt
		dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README NEWS
}

pkg_postinst(){
	einfo
	einfo "Gmrun now featers a ~/.gmrunrc see /usr/share/gmrun/gmrunrc for help"
	einfo
}

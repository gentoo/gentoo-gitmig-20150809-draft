# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-1.0.1.ebuild,v 1.14 2005/03/22 15:34:28 gustavoz Exp $

DESCRIPTION="Application for easy change of GTK-Themes"
SRC_URI="http://www.muhri.net/${P}.tar.gz"
HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*"
SLOT="1.2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

src_compile() {
	make || die
}

src_install () {
	dodir usr/share
	dodir usr/share/man
	dodir usr/share/man/man1
	make PREFIX=${D}usr install || die
	mv ${D}usr/man/* ${D}usr/share/man/man1 || die
	rm -rf ${D}usr/man
	dodoc ChangeLog readme*
}

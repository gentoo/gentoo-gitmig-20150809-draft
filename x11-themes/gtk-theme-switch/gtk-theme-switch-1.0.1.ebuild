# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-1.0.1.ebuild,v 1.1 2002/06/29 09:27:15 seemant Exp $
S=${WORKDIR}/${P}

DESCRIPTION="Application for easy change of GTK-Themes"

SRC_URI="http://www.muhri.net/${P}.tar.gz"

HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"

LICENSE="GPL"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"
SLOT="0"

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
pkg_postinstall () {
	echo "If don't works try with -02 flag in make.conf"
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtk-theme-switch/gtk-theme-switch-1.0.1.ebuild,v 1.2 2002/05/31 21:00:12 bass Exp $
S=${WORKDIR}/${P}

# Short one-line description of this package.
DESCRIPTION="Application for easy change of GTK-Themes"

SRC_URI="http://www.muhri.net/gtk-theme-switch-1.0.1.tar.gz"

HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"

LICENSE="GPL"

DEPEND="=x11-libs/gtk+-1.2.10-r8"
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
}


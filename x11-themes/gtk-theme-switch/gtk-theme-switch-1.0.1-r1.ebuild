# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-1.0.1-r1.ebuild,v 1.9 2005/03/22 15:34:28 gustavoz Exp $

inherit eutils

DESCRIPTION="Application for easy change of GTK-Themes"
HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"
SRC_URI="http://www.muhri.net/${P}.tar.gz
	mirror://gentoo/${P}b.patch.gz"

SLOT="1.2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}b.patch
}

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

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-1.0.1-r2.ebuild,v 1.1 2005/03/22 16:00:53 seemant Exp $

inherit eutils

DESCRIPTION="Application for easy change of GTK-Themes"
HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"
SRC_URI="http://www.muhri.net/${P}.tar.gz
	mirror://gentoo/${P}b.patch.gz"

SLOT="1.2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~hppa ~amd64 ~ia64"
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
	mv ${D}usr/man/switch.1* ${D}usr/share/man/man1/
	mv ${D}/usr/share/man/man1/{,gtk-theme-}switch.1*
	dodoc ChangeLog readme*
}

pkg_preinst() {
	if [ ! -f ${ROOT}/usr/share/man/man1/switch.1* ]
	then
		ln -sf ${IMAGE}/usr/share/man/man1/{gtk-theme-,}switch.1.gz
	fi
}

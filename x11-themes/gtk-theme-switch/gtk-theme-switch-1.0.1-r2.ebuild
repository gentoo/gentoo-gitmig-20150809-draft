# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-1.0.1-r2.ebuild,v 1.7 2006/06/01 14:24:30 seemant Exp $

inherit eutils

DESCRIPTION="Application for easy change of GTK-Themes"
HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"
SRC_URI="http://www.muhri.net/${P}.tar.gz
	mirror://gentoo/${P}b.patch.gz"

SLOT="1.2"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
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
	dobin switch
	newman switch.1 gtk-theme-switch.1
	dosym gtk-theme-switch.1 /usr/share/man/man1/switch.1
	dodoc ChangeLog readme*
}

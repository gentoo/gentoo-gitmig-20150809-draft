# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-2.0.0_rc2-r1.ebuild,v 1.3 2004/02/17 07:42:07 mr_bones_ Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Application for easy change of GTK-Themes"
HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"
SRC_URI="http://www.muhri.net/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}b.patch.gz"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~ppc64"

DEPEND="=x11-libs/gtk+-2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_P}b.patch
}

src_compile() {
	make || die
}

src_install () {

	dobin switch2
	mv switch.1 switch2.1
	doman switch2.1
}

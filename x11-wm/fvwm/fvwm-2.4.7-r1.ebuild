# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.4.7-r1.ebuild,v 1.10 2003/03/27 11:45:24 seemant Exp $

IUSE="ncurses gtk gnome"


S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
HOMEPAGE="http://www.fvwm.org/"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2
	http://www.igs.net/~tril/fvwm/configs/fvwm-patch"

SLOT="0"
LICENSE="GPL-2 FVWM"
KEYWORDS="x86 sparc"

DEPEND=">=dev-libs/libstroke-0.4
	gtk? ( =x11-libs/gtk+-1.2* )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	ncurses? ( >=sys-libs/readline-4.1 )"

src_unpack() {
	
	unpack ${P}.tar.bz2
	cd ${S}
	patch -p0 < ${DISTDIR}/${PN}-patch
}

src_compile() {

	econf `use_with gnome` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/fvwm2
}

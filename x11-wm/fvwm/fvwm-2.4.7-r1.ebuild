# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.4.7-r1.ebuild,v 1.4 2002/08/14 15:45:39 murphy Exp $


S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2
	http://www.igs.net/~tril/fvwm/configs/fvwm-patch"
HOMEPAGE="http://www.fvwm.org/"
LICENSE="GPL-2 & FVWM"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

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
	local myconf

	use gnome	\
		&& myconf="--with-gnome"	\
		|| myconf="--without-gnome"	\

	./configure	\
		--prefix=/usr 	\
		--host=${CHOST} \
		--libexecdir=/usr/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info	\
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/fvwm2
}

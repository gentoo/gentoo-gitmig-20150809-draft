# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.4.16.ebuild,v 1.1 2003/07/03 18:38:55 taviso Exp $

inherit gnuconfig

IUSE="ncurses gtk gnome"

S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"
LICENSE="GPL-2 FVWM"

RDEPEND="media-sound/rplay
		>=dev-libs/libstroke-0.4
		gtk? ( =x11-libs/gtk+-1.2* )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
		ncurses? ( >=sys-libs/readline-4.1 )"
DEPEND="${RDEPEND} sys-devel/automake"

src_unpack() {
	unpack ${A}
	cd ${S}
	use alpha && gnuconfig_update
}

src_compile() {
	local myconf

	use gnome \
		&& myconf="--with-gnome" \
		|| myconf="--without-gnome" \

	automake

	econf \
		--enable-multibyte \
		--libexecdir=/usr/lib \
		${myconf} || die

	emake || die
}

src_install () {
	einstall || die
	
	echo "#!/bin/bash" > fvwm2
	echo "/usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2

}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.7.ebuild,v 1.2 2003/07/30 16:02:32 taviso Exp $

inherit gnuconfig

IUSE="ncurses gtk gnome oss"

S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="-x86 -alpha"
LICENSE="GPL-2 FVWM"

RDEPEND="oss? ( media-sound/rplay )
		>=dev-libs/libstroke-0.4
		gtk? ( =x11-libs/gtk+-1.2* )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
		ncurses? ( >=sys-libs/readline-4.1 )
		media-libs/fontconfig"
DEPEND="${RDEPEND} sys-devel/automake
	dev-util/pkgconfig"

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
	
	use oss \
		&& myconf="--with-rplay" \
		|| myconf="--without-rplay"

	# CFLAGS containing comma will break this, so change it for !
	sed -i 's#\x27s,xCFLAGSx,$(CFLAGS),\x27#\x27s!xCFLAGSx!$(CFLAGS)!\x27#' \
		${S}/utils/Makefile.am

	einfo "Fixing Xft detection..."
	cp ${FILESDIR}/acinclude.m4 ${S}/acinclude.m4
 	aclocal
	autoheader
	automake --add-missing
	autoreconf
	
	econf \
		--enable-multibyte \
		--libexecdir=/usr/lib \
		--enable-xft \
		${myconf} \
		PKG_CONFIG=${ROOT}/usr/bin/pkg-config || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	echo "#!/bin/bash" > fvwm2
	echo "/usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2
}


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.2.15_pre2.ebuild,v 1.1 2004/07/22 03:54:37 morfic Exp $

inherit eutils

#this needs to use the theme for 1.2.14 probably all through pre phase
SILVERXP_P="SilverXP-1.2.14-single-1"

DESCRIPTION="Ice Window Manager"
SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.gz
	mirror://sourceforge/icewmsilverxp/${SILVERXP_P}.tar.bz2"
HOMEPAGE="http://www.icewm.org/
	http://sourceforge.net/projects/icewmsilverxp/"
IUSE="esd gnome imlib nls spell truetype xinerama silverxp"

RDEPEND="virtual/x11
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome-libs gnome-base/gnome-desktop )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )
	nls? ( sys-devel/gettext )
	truetype? ( >=media-libs/freetype-2.0.9 )
	media-fonts/artwiz-fonts"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
S=${WORKDIR}/${P/_}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	if use silverxp ; then
		epatch ${WORKDIR}/${PN}/themes/${SILVERXP_P}/Linux/ybutton.cc.patch
	fi

	echo "#!/bin/bash" > $T/icewm
	echo "/usr/bin/icewm-session" >> $T/icewm

}

src_compile(){
	use esd \
		&& myconf="${myconf} --with-esd-config=/usr/bin/esd-config"

	use nls \
		&& myconf="${myconf} --enable-nls --enable-i18n" \
		|| myconf="${myconf} --disable-nls --disable-i18n"

	use imlib \
		&& myconf="${myconf} --with-imlib --without-xpm" \
		|| myconf="${myconf} --without-imlib --with-xpm"

	use spell \
		&& myconf="${myconf} --enable-GtkSpell" \
		|| myconf="${myconf} --disable-GtkSpell"

	( use silverxp || use truetype ) \
		&& myconf="${myconf} --enable-gradients --enable-shape --enable-movesize-fx --enable-shaped-decorations" \
		|| myconf="${myconf} --disable-xfreetype --enable-corefonts"

	use x86 \
		&& myconf="${myconf} --enable-x86-asm" \
		|| myconf="${myconf} --disable-x86-asm"

	use gnome \
		&& myconf="${myconf} --enable-menus-gnome2 --enable-menus-gnome1" \
		|| myconf="${myconf} --disable-menus-gnome2 --disable-menus-gnome1"

	use xinerama \
		&& myconf="${myconf} --enable-xinerama" \
		|| myconf="${myconf} --disable-xinerama"

	CXXFLAGS="${CXXFLAGS}" econf \
		--with-libdir=/usr/share/icewm \
		--with-cfgdir=/etc/icewm \
		--with-docdir=/usr/share/doc/${PF}/html \
		${myconf} || die "configure failed"

	sed -i "s:/icewm-\$(VERSION)::" src/Makefile || die "patch failed"


	emake || die "emake failed"
}

src_install(){
	make DESTDIR=${D} install || die  "make instal failed"

	dodoc AUTHORS BUGS CHANGES FAQ PLATFORMS README* TODO VERSION
	dohtml -a html,sgml doc/*

	exeinto /etc/X11/Sessions
	doexe $T/icewm
}

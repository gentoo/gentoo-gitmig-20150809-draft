# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.2.11.ebuild,v 1.3 2003/08/20 15:14:48 bcowan Exp $

DESCRIPTION="Ice Window Manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.icewm.org"
IUSE="esd gnome imlib nls spell truetype"

DEPEND="virtual/x11
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome-libs )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )
	nls? ( sys-devel/gettext )
	truetype? ( >=media-libs/freetype-2.0.9 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

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

	use truetype \
		&& myconf="${myconf} --enable-gradients" \
		|| myconf="${myconf} --disable-xfreetype"

	use x86 \
		&& myconf="${myconf} --enable-x86-asm" \
		|| myconf="${myconf} --disable-x86-asm"

	use gnome \
		&& myconf="${myconf} --enable-menus-gnome2" \
		|| myconf="${myconf} --disable-menus-gnome2"

	CXXFLAGS="${CXXFLAGS}" econf \
		--with-libdir=/usr/share/icewm \
		--with-cfgdir=/etc/icewm \
		--with-docdir=/usr/share/doc/${PF}/html \
		${myconf} || die "configure failed"
	cd src
	sed -i "s:/icewm-\$(VERSION)::" Makefile || die "patch failed"
	cd ${S}

	emake || die "emake failed"
}

src_install(){
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS CHANGES COPYING FAQ PLATFORMS README* TODO VERSION
	dohtml -a html,sgml doc/*

	echo "#!/bin/bash" > icewm
	echo "/usr/bin/icewm" >> icewm
	exeinto /etc/X11/Sessions
	doexe icewm
}

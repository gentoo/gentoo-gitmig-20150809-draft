# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.2.13.ebuild,v 1.5 2004/03/25 14:43:09 jhuebel Exp $

DESCRIPTION="Ice Window Manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.icewm.org"
IUSE="esd gnome imlib nls spell truetype"

DEPEND="virtual/x11
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome-libs gnome-base/gnome-desktop )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )
	nls? ( sys-devel/gettext )
	truetype? ( >=media-libs/freetype-2.0.9 )"

RDEPEND="${DEPEND}
	media-fonts/artwiz-fonts"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc amd64"
S=${WORKDIR}/${P}

# rcg12302003 Various patches to configure.in...
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-gentoo.patch
}

src_compile(){
	# rcg12302003 We patch configure.in, so rebuild the configure script...
	./autogen.sh

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
		&& myconf="${myconf} --enable-gradients --enable-shape --enable-movesize-fx --enable-shaped-decorations" \
		|| myconf="${myconf} --disable-xfreetype"

	use x86 \
		&& myconf="${myconf} --enable-x86-asm" \
		|| myconf="${myconf} --disable-x86-asm"

	use gnome \
		&& myconf="${myconf} --enable-menus-gnome2 --enable-menus-gnome1" \
		|| myconf="${myconf} --disable-menus-gnome2 --disable-menus-gnome1"

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
	echo "/usr/bin/icewm-session" >> icewm
	exeinto /etc/X11/Sessions
	doexe icewm
}

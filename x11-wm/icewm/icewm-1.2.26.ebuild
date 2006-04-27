# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.2.26.ebuild,v 1.1 2006/04/27 01:41:54 morfic Exp $

inherit eutils

DESCRIPTION="Ice Window Manager with Themes"

HOMEPAGE="http://www.icewm.org/
	http://sourceforge.net/projects/icewmsilverxp/"

#fix for icewm preversion package names
S=${WORKDIR}/${P/_}

SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="esd gnome imlib nls spell truetype xinerama silverxp"

RDEPEND="|| ( (
		x11-libs/libXau
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libXext
		x11-libs/libXpm
		x11-libs/libXrender
		x11-libs/libXft
		x11-libs/libXt
		x11-libs/libXdmcp )
	virtual/x11 )
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome-libs gnome-base/gnome-desktop dev-util/pkgconfig )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )
	nls? ( sys-devel/gettext )
	truetype? ( >=media-libs/freetype-2.0.9 )
	media-fonts/artwiz-fonts
	media-libs/giflib"

DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto
		x11-proto/xineramaproto )
	virtual/x11 )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd ${S}/src
	if use silverxp ; then
		epatch ${FILESDIR}/${P/_}.ybutton.cc.patch
	fi

	echo "#!/bin/sh" > $T/icewm
	echo "/usr/bin/icewm-session" >> $T/icewm

}

src_compile(){

	if use truetype
	then
		myconf="${myconf} --enable-gradients --enable-shape --enable-movesize-fx --enable-shaped-decorations"
	else
		myconf="${myconf} --disable-xfreetype --enable-corefonts"
	fi

	CXXFLAGS="${CXXFLAGS}" econf \
		--with-libdir=/usr/share/icewm \
		--with-cfgdir=/etc/icewm \
		--with-docdir=/usr/share/doc/${PF}/html \
		$(use_with esd esd-config /usr/bin/esd-config) \
		$(use_enable nls) \
		$(use_enable nls i18n) \
		$(use_with imlib) \
		$(use_enable spell GtkSpell) \
		$(use_enable x86 x86-asm) \
		$(use_enable xinerama) \
		$(use_enable gnome menus-gnome1) \
		$(use_enable gnome menus-gnome2) \
		${myconf} || die "configure failed"

	sed -i "s:/icewm-\$(VERSION)::" src/Makefile || die "patch failed"
	sed -i "s:ungif:gif:" src/Makefile || die "libungif fix failed"

	emake || die "emake failed"
}

src_install(){
	make DESTDIR=${D} install || die  "make install failed"

	dodoc AUTHORS BUGS CHANGES FAQ PLATFORMS README* TODO VERSION
	dohtml -a html,sgml doc/*

	exeinto /etc/X11/Sessions
	doexe $T/icewm

	insinto /usr/share/xsessions
	doins ${FILESDIR}/IceWM.desktop
}

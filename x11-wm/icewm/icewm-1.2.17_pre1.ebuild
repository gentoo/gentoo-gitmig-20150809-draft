# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.2.17_pre1.ebuild,v 1.2 2004/10/24 23:54:37 morfic Exp $

inherit eutils

DESCRIPTION="Ice Window Manager"

HOMEPAGE="http://www.icewm.org/
	http://sourceforge.net/projects/icewmsilverxp/"

#this needs to use the theme for 1.2.14 probably all through pre phase
SILVERXP_P="SilverXP-1.2.14-single-3"
#fix for icewm preversion package names
S=${WORKDIR}/${P/_}

SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.gz
	mirror://sourceforge/icewmsilverxp/${SILVERXP_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

IUSE="esd gnome imlib nls spell truetype xinerama silverxp"

RDEPEND="virtual/x11
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome-libs gnome-base/gnome-desktop dev-util/pkgconfig )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )
	nls? ( sys-devel/gettext )
	truetype? ( >=media-libs/freetype-2.0.9 )
	media-fonts/artwiz-fonts
	media-libs/libungif"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/icewm-1.2.17_pre1.wmtaskbar.cc.patch
	if use silverxp ; then
		epatch ${WORKDIR}/${PN}/themes/${SILVERXP_P}/Linux/ybutton.cc.patch
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

	if use silversp
	then
	einfo "Please use Version 1.2.14-3 of the Silverxp theme"
	fi
}

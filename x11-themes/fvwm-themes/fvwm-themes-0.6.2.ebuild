# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-themes/fvwm-themes-0.6.2.ebuild,v 1.4 2004/02/01 21:46:57 avenj Exp $

IUSE="gnome"

inherit eutils

DESCRIPTION="A configuration framework for the fvwm window manager"
HOMEPAGE="http://fvwm-themes.sourceforge.net/"
SRC_URI="mirror://sourceforge/fvwm-themes/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~amd64"
SLOT="0"

DEPEND="x11-wm/fvwm
	gnome? ( media-gfx/imagemagick )"
RDEPEND="x11-wm/fvwm"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	local myconf

	use gnome && myconf="--enable-gnome-icons"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}


src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}

pkg_postinst() {
	einfo
	einfo "Configuring ${P}"
	einfo

	fvwm-themes-config --site --reset
	fvwm-themes-menuapp --site --build-menus --remove-popup

	use gnome && fvwm-themes-images --ft-install --gnome
}

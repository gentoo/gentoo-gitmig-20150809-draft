# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-2.20050306.ebuild,v 1.2 2005/04/09 13:10:48 lucass Exp $

MY_P="${P/-2./-}"
DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency."
HOMEPAGE="http://fvwm-crystal.berlios.de/"
SRC_URI="http://fvwm-crystal.berlios.de/files/files/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="xmms"
RDEPEND=">=x11-wm/fvwm-2.5.12
	app-admin/sudo
	dev-python/pyxml
	media-gfx/imagemagick
	media-sound/aumix
	x11-misc/habak
	x11-misc/trayer
	xmms? ( media-plugins/xmms-shell
		>=media-sound/xmms-1.2.7
		media-plugins/xmms-find )"

S=${WORKDIR}/${MY_P}

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	dodoc AUTHORS COPYING INSTALL NEWS README doc/*
	dobin bin/*

	dodir /usr/share/${PN}
	cp -r addons fvwm ${D}/usr/share/${PN}

	# Original session file doesn't work on Gentoo
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/fvwm-crystal

	insinto /usr/share/xsessions
	doins addons/gdm/fvwm-crystal.desktop
}

pkg_postinst() {
	einfo ""
	einfo "This is a new branch of fvwm-crystal theme. If you prefer"
	einfo "to stay with versions 1.x, put the following line in"
	einfo "/etc/portage/package.mask, and reemerge fvwm-crystal:"
	einfo " >=x11-themes/fvwm-crystal-2*"
	einfo ""
	einfo "After installation, execute following commands:"
	einfo " $ cp -r /usr/share/${PN}/addons/Xresources-EN ~/.Xresources"
	einfo " $ cp -r /usr/share/${PN}/addons/Xsession ~/.xinitrc"
	einfo ""
	einfo "Authors of fvwm-crystal recommend also installing"
	einfo "the following applications:"
	einfo " app-admin/gkrellm"
	einfo " app-misc/rox"
	einfo " media-gfx/scrot"
	einfo " x11-misc/xlockmore"
	einfo " x11-misc/xpad"
	einfo " x11-misc/xscreensaver"
	einfo " x11-terms/aterm"
	einfo ""
}


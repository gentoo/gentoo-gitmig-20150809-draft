# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-3.0_rc1.ebuild,v 1.2 2005/08/09 00:12:40 metalgod Exp $

MY_P="${P/_rc/.RC}"
DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency."
HOMEPAGE="http://fvwm-crystal.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="xmms"
RDEPEND=">=x11-wm/fvwm-2.5.13
	app-admin/sudo
	dev-python/pyxml
	media-gfx/imagemagick
	media-sound/aumix
	x11-misc/trayer
	|| ( x11-misc/habak x11-terms/eterm )
	xmms? ( media-plugins/xmms-shell
		>=media-sound/xmms-1.2.7
		media-plugins/xmms-find )
	!xmms? ( media-sound/mpd
		media-sound/mpc )"

S=${WORKDIR}/${MY_P}

src_install() {
	einstall

	dodoc AUTHORS COPYING INSTALL NEWS README doc/*

	dodir /usr/share/${PN}
	cp -r addons ${D}/usr/share/${PN}

	# Original session file doesn't work on Gentoo
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/fvwm-crystal

	insinto /usr/share/xsessions
	doins addons/fvwm-crystal.desktop
}

pkg_postinst() {
	einfo
	einfo "After installation, execute following commands:"
	einfo " $ cp -r /usr/share/${PN}/addons/Xresources ~/.Xresources"
	einfo " $ cp -r /usr/share/${PN}/addons/Xsession ~/.xinitrc"
	einfo
	einfo "Authors of fvwm-crystal recommend also installing"
	einfo "the following applications:"
	einfo " app-admin/gkrellm"
	einfo " app-misc/rox"
	einfo " media-gfx/scrot"
	einfo " x11-misc/xlockmore"
	einfo " x11-misc/xpad"
	einfo " x11-misc/xscreensaver"
	einfo " x11-terms/aterm"
	einfo
}


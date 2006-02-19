# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-3.0.ebuild,v 1.2 2006/02/19 14:03:30 lucass Exp $

DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency."
HOMEPAGE="http://fvwm-crystal.org/"
SRC_URI="http://download.gna.org/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND=">=x11-wm/fvwm-2.5.13
	dev-python/pyxml
	media-gfx/imagemagick
	x11-misc/trayer
	|| ( >=x11-misc/habak-0.2.4.1 x11-misc/hsetroot )"

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
	einfo "Many applications can extend functionality of fvwm-crystal."
	einfo "They are listed in /usr/share/doc/${PF}/INSTALL.gz."
	einfo
}


# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-3.0.5.ebuild,v 1.2 2007/06/09 20:11:01 lucass Exp $

DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency."
HOMEPAGE="http://fvwm-crystal.org/"
SRC_URI="http://download.gna.org/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND=">=x11-wm/fvwm-2.5.13
	media-gfx/imagemagick
	|| ( x11-misc/stalonetray x11-misc/trayer )
	|| ( x11-misc/habak x11-misc/hsetroot )"

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	einstall || die "einstall failed"

	dodoc AUTHORS COPYING README INSTALL NEWS ChangeLog doc/*

	insinto /usr/share/doc/${PF}
	doins -r addons

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/fvwm-crystal

	insinto /usr/share/xsessions
	doins addons/fvwm-crystal.desktop
}

pkg_postinst() {
	elog
	elog "After installation, execute following commands:"
	elog " $ cp -r /usr/share/doc/${PF}/addons/Xresources ~/.Xresources"
	elog " $ cp -r /usr/share/doc/${PF}/addons/Xsession ~/.xinitrc"
	elog
	elog "Many applications can extend functionality of fvwm-crystal."
	elog "They are listed in /usr/share/doc/${PF}/INSTALL.gz."
	elog
}

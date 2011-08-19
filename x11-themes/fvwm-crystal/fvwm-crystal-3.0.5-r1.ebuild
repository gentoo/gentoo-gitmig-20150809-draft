# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-3.0.5-r1.ebuild,v 1.8 2011/08/19 11:45:27 xarthisius Exp $

inherit eutils

DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency."
HOMEPAGE="http://gna.org/projects/fvwm-crystal/"
SRC_URI="http://download.gna.org/${PN}/${PV}/${P}.tar.gz
	mirror://gentoo/${P}-envfix.patch.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND=">=x11-wm/fvwm-2.5.13
	media-gfx/imagemagick
	|| ( x11-misc/stalonetray x11-misc/trayer )
	|| ( x11-misc/habak x11-misc/hsetroot )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-envfix.patch"
	sed -e 's/MenuPosition-/MenuPosition_/g' \
		-i bin/fvwm-crystal.apps
}

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	einstall || die "einstall failed"

	dodoc AUTHORS README INSTALL NEWS ChangeLog doc/*

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
	ewarn "In this release, all hyphens (-) in names of env variables"
	ewarn "used by FVWM-Crystal have been replaced by underscores (_)."
	ewarn "You may need to update your configuration."
}

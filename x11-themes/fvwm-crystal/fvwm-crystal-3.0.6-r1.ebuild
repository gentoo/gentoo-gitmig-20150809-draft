# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-3.0.6-r1.ebuild,v 1.1 2009/06/26 20:04:35 tommy Exp $

inherit eutils

DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency"
HOMEPAGE="http://fvwm-crystal.org/"
SRC_URI="http://download.gna.org/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND=">=x11-wm/fvwm-2.5.13
	dev-lang/python
	media-gfx/imagemagick
	|| ( x11-misc/stalonetray x11-misc/trayer )
	|| ( x11-misc/habak x11-misc/hsetroot )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -type d -name '.svn' -prune -exec rm -rf {} ';' || die
	epatch "${FILESDIR}/fvwm-crystal.apps.patch"
}

src_install() {
	einstall || die "einstall failed"

	dodoc AUTHORS README INSTALL NEWS ChangeLog doc/* || die

	docinto examples
	dodoc addons/* || die

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/fvwm-crystal || die

	insinto /usr/share/xsessions
	doins addons/fvwm-crystal.desktop || die
}

pkg_postinst() {
	einfo
	einfo "Configuration examples can be found in ${ROOT}usr/share/doc/${PF}/examples/"
	einfo
	einfo "Many applications can extend functionality of fvwm-crystal."
	einfo "They are listed in the INSTALL file in ${ROOT}usr/share/doc/${PF}."
	einfo
	ewarn "In this release, all hyphens (-) in names of env variables"
	ewarn "used by FVWM-Crystal have been replaced by underscores (_)."
	ewarn "You may need to update your configuration."
}

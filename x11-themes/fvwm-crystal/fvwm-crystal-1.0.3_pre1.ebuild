# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm-crystal/fvwm-crystal-1.0.3_pre1.ebuild,v 1.2 2004/04/01 09:38:07 taviso Exp $

DESCRIPTION="Configurable and full featured theme for FVWM, with lots of transparency."
HOMEPAGE="http://fvwm-crystal.linuxpl.org/"
SRC_URI="ftp://ftp.linuxpl.org/fvwm-crystal/tarballs/${P/_pre/pre}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xmms"

RDEPEND=">=x11-wm/fvwm-2.5.8
	xmms? ( media-plugins/xmms-shell
		>=media-sound/xmms-1.2.7
		media-plugins/xmms-find )
	x11-misc/xdaliclock
	x11-terms/aterm
	x11-misc/habak
	media-sound/aumix"

# XXX: x11-misc/habak-0.2.3 (currently hardmasked) breaks.

S=${WORKDIR}/${P/_pre/pre}

src_install() {
	einstall || die
}

pkg_postinst() {
	einfo ""
	einfo "users should run fvwm-crystal.install to configure fvwm-crystal"
	einfo ""
	einfo ""
	einfo "fvwm-crystal authors also recommend the following applications:"
	einfo ""
	einfo "	app-misc/rox"
	einfo "	media-gfx/scrot"
	einfo "	x11-misc/xlockmore"
	einfo ""
}

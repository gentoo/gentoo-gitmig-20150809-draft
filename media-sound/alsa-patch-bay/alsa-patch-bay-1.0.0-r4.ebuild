# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-patch-bay/alsa-patch-bay-1.0.0-r4.ebuild,v 1.6 2009/05/12 16:15:49 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Graphical patch bay for the ALSA sequencer API."
HOMEPAGE="http://pkl.net/~node/software/alsa-patch-bay/index.html"
SRC_URI="http://pkl.net/~node/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="alsa jack ladcca"

DEPEND="x11-libs/fltk:1.1
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
	jack? ( media-sound/jack-audio-connection-kit )
	ladcca? ( media-libs/ladcca )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_configure() {
	econf \
		--enable-fltk \
		--disable-gtkmm \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable ladcca)
}

src_install() {
	einstall APB_DESKTOP_PREFIX="${D}"/usr/share || die "einstall failed"
	dodoc AUTHORS NEWS README THANKS TODO
}

pkg_preinst() {
	if [ -e "${D}"/usr/bin/jack-patch-bay ]
	then
		rm "${D}"/usr/bin/jack-patch-bay
		ln -s alsa-patch-bay "${D}"/usr/bin/jack-patch-bay
	fi
}

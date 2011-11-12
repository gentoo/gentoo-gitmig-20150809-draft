# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmtp/gmtp-1.2.0.ebuild,v 1.2 2011/11/12 11:30:18 tomka Exp $

EAPI=4

inherit eutils gnome2-utils

DESCRIPTION="simple MP3 player client for MTP based devices"
HOMEPAGE="http://gmtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PF}-i386.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+
gnome-base/gconf
media-libs/libmtp
media-libs/libid3tag
dev-libs/libusb
media-libs/flac
media-libs/libvorbis"

RDEPEND="${DEPEND}"

S="${WORKDIR}/gMTP"

src_prepare() {
	epatch "${FILESDIR}/${PF}-makefile-gentoo.patch"
}

pkg_preinst() {
	gnome2_gconf_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_icon_cache_update
}

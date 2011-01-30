# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/padevchooser/padevchooser-0.9.3-r1.ebuild,v 1.5 2011/01/30 08:54:16 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="PulseAudio Device Chooser, tool for quick access to PulseAudio features"
HOMEPAGE="http://0pointer.de/lennart/projects/padevchooser/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"

IUSE=""

DEPEND="x11-libs/gtk+:2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	x11-libs/libnotify
	>=media-sound/pulseaudio-0.9.2[avahi,glib]"
RDEPEND="${DEPEND}
	|| ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_configure() {
	# Lynx is used during make dist basically
	econf \
		--disable-dependency-tracking \
		--disable-lynx
}

src_install() {
	emake DESTDIR="${D}" install || die
	dohtml -r doc
	dodoc README
}

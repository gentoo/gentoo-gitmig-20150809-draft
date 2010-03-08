# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/padevchooser/padevchooser-0.9.3-r1.ebuild,v 1.2 2010/03/08 17:04:15 hwoarang Exp $

EAPI=2

inherit eutils

DESCRIPTION="PulseAudio Device Chooser, tool for quick access to PulseAudio features"
HOMEPAGE="http://0pointer.de/lennart/projects/padevchooser/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc ~x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gconf-2.0
	x11-libs/libnotify
	>=media-sound/pulseaudio-0.9.2[avahi,glib]"
RDEPEND="${DEPEND}
	x11-themes/gnome-icon-theme"

src_configure() {
	# Lynx is used during make dist basically
	econf \
		--disable-dependency-tracking \
		--disable-lynx || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc
	dodoc README doc/todo
}

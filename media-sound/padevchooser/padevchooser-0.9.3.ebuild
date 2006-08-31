# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/padevchooser/padevchooser-0.9.3.ebuild,v 1.2 2006/08/31 11:11:16 flameeyes Exp $

inherit eutils

DESCRIPTION="PulseAudio Device Chooser, tool for quick access to PulseAudio features"
HOMEPAGE="http://0pointer.de/lennart/projects/pavucontrol/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gconf-2.0
	x11-libs/libnotify
	>=media-sound/pulseaudio-0.9.2"

pkg_setup() {
	# See bug #145648
	if ! built_with_use media-sound/pulseaudio avahi; then
		eerror "You need to build media-sound/pulseaudio with 'avahi' use flag enabled."
		die "Missing avahi use flag on media-sound/pulseaudio."
	fi
}

src_compile() {
	# Lynx is used during make dist basically
	econf \
		--disable-dependency-tracking \
		--disable-lynx || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc
	dodoc README doc/todo
}


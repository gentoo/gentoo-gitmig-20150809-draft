# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavumeter/pavumeter-0.9.3-r1.ebuild,v 1.1 2008/10/09 21:44:11 flameeyes Exp $

EAPI=2

inherit eutils

DESCRIPTION="PulseAudio Volume Meter, simple GTK volume meter for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/pavumeter/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-libs/libsigc++-2.0
	>=media-sound/pulseaudio-0.9.7[glib]"
RDEPEND="${DEPEND}
	x11-themes/gnome-icon-theme"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_configure() {
	# Lynx is used during make dist basically
	econf \
		--disable-dependency-tracking \
		--disable-lynx || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc
	dodoc README
}

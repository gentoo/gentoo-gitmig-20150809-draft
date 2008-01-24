# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavumeter/pavumeter-0.9.3.ebuild,v 1.5 2008/01/24 01:21:51 flameeyes Exp $

DESCRIPTION="PulseAudio Volume Meter, simple GTK volume meter for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/pavumeter/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-libs/libsigc++-2.0
	>=media-sound/pulseaudio-0.9.7"
RDEPEND="${DEPEND}
	x11-themes/gnome-icon-theme"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use --missing true media-sound/pulseaudio glib; then
		eerror "You need to build media-sound/pulseaudio with 'glib' use flag enabled."
		die "Missing glib use flag on media-sound/pulseaudio."
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
	dodoc README
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paprefs/paprefs-0.9.7.ebuild,v 1.1 2008/10/10 13:06:25 flameeyes Exp $

EAPI=2

inherit eutils

DESCRIPTION="PulseAudio Preferences, configuration dialog for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/paprefs"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="nls"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-libs/libsigc++-2
	>=media-sound/pulseaudio-0.9.5[glib]
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext dev-util/intltool )
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable nls) --disable-lynx
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dohtml -r doc
	dodoc README
}

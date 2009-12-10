# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paprefs/paprefs-0.9.9.ebuild,v 1.2 2009/12/10 18:00:49 ssuominen Exp $

EAPI=2

DESCRIPTION="PulseAudio Preferences, configuration dialog for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/paprefs"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

# Icon Theme is used for Icon=preferences-desktop in desktop entry.
RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-libs/libsigc++-2.2:2
	>=media-sound/pulseaudio-0.9.5[glib]
	|| ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		dev-util/intltool )
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-lynx \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dohtml -r doc
	dodoc README
}

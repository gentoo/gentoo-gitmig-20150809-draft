# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paprefs/paprefs-0.9.10.ebuild,v 1.1 2011/09/27 09:51:39 ford_prefect Exp $

EAPI=4

DESCRIPTION="PulseAudio Preferences, configuration dialog for PulseAudio"
HOMEPAGE="http://freedesktop.org/software/pulseaudio/paprefs"
SRC_URI="http://freedesktop.org/software/pulseaudio/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

RDEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/libglademm:2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-libs/libsigc++-2.2:2
	media-sound/pulseaudio[glib,gnome]
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
	emake DESTDIR="${D}" install || die
	dohtml -r doc
	dodoc README
}

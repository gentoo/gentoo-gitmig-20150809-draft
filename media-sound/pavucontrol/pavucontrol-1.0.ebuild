# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavucontrol/pavucontrol-1.0.ebuild,v 1.1 2011/09/27 09:48:56 ford_prefect Exp $

EAPI=4

DESCRIPTION="Pulseaudio Volume Control, GTK based mixer for Pulseaudio"
HOMEPAGE="http://freedesktop.org/software/pulseaudio/pavucontrol/"
SRC_URI="http://freedesktop.org/software/pulseaudio/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="gtk3 nls"

RDEPEND=">=dev-libs/libsigc++-2.2:2
	!gtk3? ( >=dev-cpp/gtkmm-2.16:2.4
		>=x11-libs/gtk+-2.16:2
		>=media-libs/libcanberra-0.16[gtk] )
	gtk3? ( >=dev-cpp/gtkmm-3.0:3.0
		>=x11-libs/gtk+-2.16:2
		>=media-libs/libcanberra-0.16[gtk3] )
	>=media-sound/pulseaudio-0.9.16[glib]
	|| ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		dev-util/intltool )
	dev-util/pkgconfig"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html \
		--disable-dependency-tracking \
		--disable-lynx \
		$(use_enable gtk3) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install
}

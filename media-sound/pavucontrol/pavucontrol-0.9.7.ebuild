# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavucontrol/pavucontrol-0.9.7.ebuild,v 1.3 2009/05/27 07:13:25 ssuominen Exp $

EAPI=2

inherit eutils

DESCRIPTION="Pulseaudio Volume Control, GTK based mixer for Pulseaudio"
HOMEPAGE="http://0pointer.de/lennart/projects/pavucontrol/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"

IUSE="nls"

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=dev-libs/libsigc++-2.0
	>=media-sound/pulseaudio-0.9.12[glib]
	media-libs/libcanberra[gtk]"

RDEPEND="${DEPEND}
	x11-themes/gnome-icon-theme"

DEPEND="${DEPEND}
	nls? ( sys-devel/gettext dev-util/intltool )
	dev-util/pkgconfig"

src_configure() {
	# Lynx is used during make dist basically
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking \
		--disable-lynx || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc || die
	dodoc README || die
}

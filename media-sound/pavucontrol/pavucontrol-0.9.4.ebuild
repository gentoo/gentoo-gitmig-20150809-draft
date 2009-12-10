# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavucontrol/pavucontrol-0.9.4.ebuild,v 1.8 2009/12/10 18:02:32 ssuominen Exp $

DESCRIPTION="Pulseaudio Volume Control, GTK based mixer for Pulseaudio"
HOMEPAGE="http://0pointer.de/lennart/projects/pavucontrol/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"

IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=dev-libs/libsigc++-2.2
	>=media-sound/pulseaudio-0.9.2"

RDEPEND="${DEPEND}
	x11-themes/gnome-icon-theme"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

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

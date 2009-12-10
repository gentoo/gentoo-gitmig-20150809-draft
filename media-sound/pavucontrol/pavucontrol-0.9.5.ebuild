# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pavucontrol/pavucontrol-0.9.5.ebuild,v 1.7 2009/12/10 18:02:32 ssuominen Exp $

inherit eutils

DESCRIPTION="Pulseaudio Volume Control, GTK based mixer for Pulseaudio"
HOMEPAGE="http://0pointer.de/lennart/projects/pavucontrol/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=dev-libs/libsigc++-2.2
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
	dodoc README doc/todo
}

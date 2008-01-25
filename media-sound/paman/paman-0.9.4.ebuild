# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paman/paman-0.9.4.ebuild,v 1.6 2008/01/25 14:20:49 armin76 Exp $

inherit eutils

DESCRIPTION="Pulseaudio Manager, a simple GTK frontend for Pulseaudio"
HOMEPAGE="http://0pointer.de/lennart/projects/paman/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86 ~x86-fbsd"

IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=media-sound/pulseaudio-0.9.5"
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
		--disable-lynx || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc
	dodoc README
}

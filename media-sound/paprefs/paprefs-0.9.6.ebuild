# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paprefs/paprefs-0.9.6.ebuild,v 1.9 2009/12/10 18:00:49 ssuominen Exp $

inherit eutils

DESCRIPTION="PulseAudio Preferences, configuration dialog for PulseAudio"
HOMEPAGE="http://0pointer.de/lennart/projects/paprefs"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="nls"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-libs/libsigc++-2.2
	>=media-sound/pulseaudio-0.9.5
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext dev-util/intltool )
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use --missing true media-sound/pulseaudio glib; then
		eerror "You need to build media-sound/pulseaudio with 'glib' use flag enabled."
		die "Missing glib use flag on media-sound/pulseaudio."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf $(use_enable nls) --disable-lynx
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dohtml -r doc
	dodoc README
}

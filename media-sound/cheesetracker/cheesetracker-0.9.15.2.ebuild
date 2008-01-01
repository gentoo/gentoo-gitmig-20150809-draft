# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cheesetracker/cheesetracker-0.9.15.2.ebuild,v 1.3 2008/01/01 15:55:02 maekke Exp $

inherit eutils

DESCRIPTION="A clone of Impulse Tracker with some extensions and a built-in sample editor"
HOMEPAGE="http://cheesetracker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE="alsa examples jack"

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	media-libs/audiofile
	=dev-libs/libsigc++-1.2*
	=x11-libs/qt-3*"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.94-r2
	dev-util/pkgconfig"

src_compile() {
	scons || die "scons failed."
}

src_install() {
	dodir /usr/bin
	scons prefix="${D}/usr" install || die "scons install failed."

	dodoc ChangeLog TODO ${PN}/{AUTHORS,README,docs/*.txt}

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins ${PN}/examples/{*.it,*.xm}
	fi

	newicon ${PN}/icons/cheese_48x48.xpm ${PN}.xpm
	make_desktop_entry ${PN}_qt CheeseTracker ${PN} "AudioVideo;Qt;"
}

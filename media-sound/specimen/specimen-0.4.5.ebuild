# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/specimen/specimen-0.4.5.ebuild,v 1.3 2004/12/04 11:54:28 eradicator Exp $

DESCRIPTION="A Midi Controllable Audio Sampler"
HOMEPAGE="http://www.gazuga.net"
SRC_URI="http://www.gazuga.net/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
#-amd64: 0.4.5: int/pointer casting
KEYWORDS="-amd64 ~ppc ~sparc ~x86"

IUSE="ladcca debug"

DEPEND="media-sound/jack-audio-connection-kit
	virtual/alsa
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/phat
	dev-libs/libxml2
	>x11-libs/gtk+-2*
	gnome-base/libgnomecanvas
	ladcca? ( media-libs/ladcca )"

src_compile() {

	econf \
		$(use_enable ladcca) \
		$(use_enable debug) || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

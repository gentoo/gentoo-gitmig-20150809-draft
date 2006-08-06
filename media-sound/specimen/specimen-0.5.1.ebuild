# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/specimen/specimen-0.5.1.ebuild,v 1.1 2006/08/06 05:04:20 matsuu Exp $

inherit eutils

DESCRIPTION="A Midi Controllable Audio Sampler"
HOMEPAGE="http://gazuga.net/specimen/"
SRC_URI="http://gazuga.net/specimen/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND="media-sound/jack-audio-connection-kit
	>=media-libs/alsa-lib-0.9
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/phat
	dev-libs/libxml2
	>=x11-libs/gtk+-2
	gnome-base/libgnomecanvas"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}

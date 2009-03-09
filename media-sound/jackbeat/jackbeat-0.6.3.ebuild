# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jackbeat/jackbeat-0.6.3.ebuild,v 1.2 2009/03/09 16:55:37 armin76 Exp $

DESCRIPTION="An audio sequencer for Linux"
HOMEPAGE="http://www.samalyse.com/jackbeat/"
SRC_URI="http://www.samalyse.com/jackbeat/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-sound/jack-audio-connection-kit
	>=x11-libs/gtk+-2.6
	>=media-libs/libsndfile-1.0.15
	>=dev-libs/libxml2-2.6
	>=media-libs/libsamplerate-0.1.2"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO
}

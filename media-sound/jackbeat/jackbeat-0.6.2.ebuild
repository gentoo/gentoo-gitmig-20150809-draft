# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jackbeat/jackbeat-0.6.2.ebuild,v 1.1 2008/01/22 13:59:32 aballier Exp $

DESCRIPTION="An audio sequencer for Linux"
HOMEPAGE="http://www.samalyse.com/jackbeat/"
SRC_URI="http://www.samalyse.com/jackbeat/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
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

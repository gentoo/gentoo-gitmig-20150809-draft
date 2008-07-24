# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-smf-utils/jack-smf-utils-1.0.ebuild,v 1.3 2008/07/24 18:59:16 armin76 Exp $

DESCRIPTION="Utilities for MIDI streams and files using Jack MIDI"
HOMEPAGE="http://pin.if.uz.zgora.pl/~trasz/jack-smf-utils/"
SRC_URI="http://pin.if.uz.zgora.pl/~trasz/jack-smf-utils/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lash readline"

RDEPEND="readline? ( sys-libs/readline )
	>=dev-libs/glib-2.2
	>=media-sound/jack-audio-connection-kit-0.102
	lash? ( media-sound/lash )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_with readline) \
		$(use_with lash)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO
}

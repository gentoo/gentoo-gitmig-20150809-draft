# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.2.15.ebuild,v 1.3 2006/01/07 18:56:07 carlo Exp $

inherit eutils kde-functions

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit and ALSA sequencer connections."
HOMEPAGE="http://qjackctl.sf.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	media-libs/alsa-lib
	media-sound/jack-audio-connection-kit"
need-qt 3

src_install() {
	make prefix="${D}/usr" DESTDIR="${D}" install || die "make install failed"
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.0.8.ebuild,v 1.5 2004/07/14 20:52:42 agriffis Exp $

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit"
HOMEPAGE="http://qjackctl.sf.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc
	>=x11-libs/qt-3.1.1
	>=media-sound/jack-audio-connection-kit-0.80.0"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall
}

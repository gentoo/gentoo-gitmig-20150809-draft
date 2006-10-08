# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darksnow/darksnow-0.6.1.ebuild,v 1.1 2006/10/08 05:46:32 matsuu Exp $

DESCRIPTION="Streaming GTK2 Front-End based in Darkice Ice Streamer"
HOMEPAGE="http://darksnow.radiolivre.org"
SRC_URI="http://darksnow.radiolivre.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2"
RDEPEND="${DEPEND}
	>=media-sound/darkice-0.14"

src_install () {
	dobin darksnow || die "could not install darksnow executable"
	dodoc "${S}"/documentation/{CHANGES,README*}
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darksnow/darksnow-0.5.ebuild,v 1.3 2007/07/11 19:30:24 mr_bones_ Exp $

DESCRIPTION="Streaming GTK2 Front-End based in Darkice Ice Streamer"
HOMEPAGE="http://darksnow.radiolivre.org"
SRC_URI="http://darksnow.radiolivre.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=media-sound/darkice-0.14"

src_unpack() {
	unpack ${A}
	cd ${S}

	#fix some makefile issues
	sed -i -e "s:^PREFIX=.*:PREFIX=${D}/usr:" \
	-e "s:^INTLPREFIX=.*:INTLPREFIX=${D}/usr:" \
	-e "s:^CFLAGS=:CFLAGS=${CFLAGS} :" \
	Makefile.in \
	|| die "could not patch Makefile"
}

src_install () {
	dobin darksnow || die "could not install darksnow executable"
	dodoc ${S}/documentation/{CHANGES,README.en}
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darksnow/darksnow-0.4.4.ebuild,v 1.4 2004/11/23 04:12:08 eradicator Exp $

IUSE=""

DESCRIPTION="Streaming GTK2 Front-End based in Darkice Ice Streamer"
HOMEPAGE="http://darksnow.radiolivre.org"
SRC_URI="http://darksnow.radiolivre.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND=">=x11-libs/gtk+-2
	>=media-sound/darkice-0.14"

src_unpack() {
	unpack ${A}
	einfo "Patching Makefile..."
	cd ${S}

	#fix some makefile issues
	sed -i -e "s:^PREFIX=.*:PREFIX=${D}/usr:" \
	-e "s:^INTLPREFIX=.*:INTLPREFIX=${D}/usr:" \
	-e "s:^CFLAGS=:CFLAGS=${CFLAGS} :" \
	Makefile \
	|| die "could not patch Makefile"
}

src_compile() {
	emake || die "Compilation failed"
}

src_install () {
	dobin darksnow || die "could not install darksnow executable"
	dodoc ${S}/documentation/*
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darksnow/darksnow-0.4.4.ebuild,v 1.3 2004/10/19 06:01:29 chriswhite Exp $


DESCRIPTION="Streaming GTK2 Front-End based in Darkice Ice Streamer"
HOMEPAGE="http://darksnow.radiolivre.org"
SRC_URI="http://darksnow.radiolivre.org/${P}.tar.gz"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

LICENSE="GPL-2"

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

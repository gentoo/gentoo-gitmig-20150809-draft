# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darksnow/darksnow-0.4.4.ebuild,v 1.1 2004/10/19 05:26:20 chriswhite Exp $


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
		sed -i "s:^PREFIX=.*:PREFIX=${D}/usr:" Makefile
		sed -i "s:^INTLPREFIX=.*:INTLPREFIX=${D}/usr:" Makefile
		sed -i "s:^CFLAGS=:CFLAGS=${CFLAGS} :" Makefile

		# sue me, I like funny things
		sed -i "s:#CFLAGS+=-DFUNNY:CFLAGS+=-DFUNNY:" Makefile
}

src_compile() {
		emake || die "Compilation failed"
}

src_install () {
		dobin darksnow
		cd ${S}/documentation
		dodoc *
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/trommler/trommler-3.3.ebuild,v 1.12 2004/07/20 06:37:04 eradicator Exp $

IUSE=""

DESCRIPTION="gtk+ based drum machine"
HOMEPAGE="http://muth.org/Robert/Trommler/"
SRC_URI="http://muth.org/Robert/Trommler/${P/-/.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND=">=x11-libs/gtk+-2.0.6-r1"

S="${WORKDIR}/Trommler"

src_compile() {
	sed -i 's:CFLAGS = -Wall -Werror -O9:CFLAGS = -Wall -O9:' Makefile || die
	emake || die
}

src_install() {
	dobin trommler wav2smp playsample
	dodoc README CHANGES
	dohtml index.html style.css
	insinto /usr/share/trommler/Drums
	doins Drums/*
	insinto /usr/share/trommler/Songs
	doins Songs/*
}

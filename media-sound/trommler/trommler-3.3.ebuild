# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/trommler/trommler-3.3.ebuild,v 1.6 2003/09/07 00:06:06 msterret Exp $

S="${WORKDIR}/Trommler"
DESCRIPTION="This is a gtk+ based drum machine"
HOMEPAGE="http://muth.org/Robert/Trommler/"
SRC_URI="http://muth.org/Robert/Trommler/${P/-/.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.6-r1"

src_compile() {
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

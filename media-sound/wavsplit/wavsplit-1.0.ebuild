# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavsplit/wavsplit-1.0.ebuild,v 1.2 2004/03/01 05:37:16 eradicator Exp $

DESCRIPTION="WavSplit is a simple command line tool to split WAV files"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
#RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install() {
	dobin wavsplit wavren
	doman wavsplit.1 wavren.1
	dodoc BUGS CHANGES COPYING CREDITS README README.wavren
}


# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavsplit/wavsplit-1.2.1.ebuild,v 1.3 2006/03/30 05:22:37 chriswhite Exp $

inherit eutils

DESCRIPTION="WavSplit is a simple command line tool to split WAV files"
HOMEPAGE="http://sourceforge.net/projects/wavsplit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc, -amd64: 1.0: "Only supports PCM wave format" error message.
KEYWORDS="x86 -sparc -amd64"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-large-files.patch
}


#src_compile() {
#	emake || die
#}

src_install() {
	dobin wavsplit wavren
	doman wavsplit.1 wavren.1
	dodoc BUGS CHANGES CREDITS README README.wavren
}


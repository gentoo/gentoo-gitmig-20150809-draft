# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogg2mp3/ogg2mp3-0.5-r1.ebuild,v 1.1 2009/05/12 11:33:42 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A perl script to convert Ogg Vorbis files to MP3 files."
HOMEPAGE="http://amor.cms.hu-berlin.de/~h0444y2j/linux.html"
SRC_URI="http://amor.cms.hu-berlin.de/~h0444y2j/pub/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-sound/lame
	dev-perl/String-ShellQuote
	media-sound/vorbis-tools"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-prevent_endian_swapping.patch
}

src_install() {
	dobin ogg2mp3 || die "dobin failed"
	dodoc doc/{AUTHORS,ChangeLog,README,TODO}
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mp3fs/mp3fs-0.13.ebuild,v 1.1 2009/01/03 06:53:51 dragonheart Exp $

inherit eutils autotools

DESCRIPTION="MP3FS is a read-only FUSE filesystem which transcodes FLAC audio files to MP3 when read."
HOMEPAGE="http://mp3fs.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-fs/fuse
		media-libs/libid3tag
		media-libs/flac
		media-sound/lame
		media-libs/libogg"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-automake-ldadd.patch
	eautomake
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}

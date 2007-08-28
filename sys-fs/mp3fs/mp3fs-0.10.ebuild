# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mp3fs/mp3fs-0.10.ebuild,v 1.1 2007/08/28 11:25:20 dragonheart Exp $

DESCRIPTION="MP3FS is a read-only FUSE filesystem which transcodes FLAC audio
files to MP3 on the fly when opened and read."
HOMEPAGE="http://mp3fs.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="sys-fs/fuse
		media-libs/libid3tag
		media-libs/flac
		media-sound/lame"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}

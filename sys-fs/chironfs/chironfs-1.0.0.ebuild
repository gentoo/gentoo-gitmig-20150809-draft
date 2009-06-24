# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/chironfs/chironfs-1.0.0.ebuild,v 1.1 2009/06/24 06:55:22 dragonheart Exp $

DESCRIPTION="Chiron FS - A FUSE based replication filesystem"
SRC_URI="http://chironfs.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://www.furquim.org/chironfs/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
RDEPEND=""
IUSE=""
DEPEND="sys-fs/fuse"

src_install() {
	emake DESTDIR="${D}" install || die 'install failure'
}

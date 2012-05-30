# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/bindfs/bindfs-1.10.3.ebuild,v 1.1 2012/05/30 09:23:53 radhermit Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="A FUSE filesystem for mounting a directory to another location and altering permissions"
HOMEPAGE="http://code.google.com/p/bindfs/"
SRC_URI="http://bindfs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cflags.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/bindfs/bindfs-1.9.ebuild,v 1.1 2011/12/06 12:28:53 radhermit Exp $

EAPI="4"

DESCRIPTION="A FUSE filesystem for mounting a directory to another location and altering permissions"
HOMEPAGE="http://code.google.com/p/bindfs/"
SRC_URI="http://bindfs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

RESTRICT="test"

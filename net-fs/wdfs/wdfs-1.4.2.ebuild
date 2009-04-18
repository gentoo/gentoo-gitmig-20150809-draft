# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/wdfs/wdfs-1.4.2.ebuild,v 1.4 2009/04/18 13:38:53 maekke Exp $

DESCRIPTION="WebDAV filesystem with special features for accessing subversion repositories"
HOMEPAGE="http://noedler.de/projekte/wdfs/"
SRC_URI="http://noedler.de/projekte/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=net-misc/neon-0.24.7
	 >=sys-fs/fuse-2.5"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS NEWS README
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/curlftpfs/curlftpfs-0.9.1.ebuild,v 1.2 2008/01/21 08:53:57 genstef Exp $

DESCRIPTION="CurlFtpFS is a filesystem for acessing ftp hosts based on FUSE"
HOMEPAGE="http://curlftpfs.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=net-misc/curl-7.17.0
	>=sys-fs/fuse-2.2
	>=dev-libs/glib-2.0"

DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc README
}

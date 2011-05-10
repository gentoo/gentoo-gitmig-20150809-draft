# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/s3fs/s3fs-1.40.ebuild,v 1.1 2011/05/10 08:23:41 xmw Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Amazon mounting S3 via fuse"
HOMEPAGE="http://s3fs.googlecode.com/"
SRC_URI="http://s3fs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6
	dev-libs/openssl
	>=net-misc/curl-7.0
	>=sys-fs/fuse-2.8.4"

RDEPEND="${DEPEND}
	app-misc/mime-types"

RESTRICT=test

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README || die
}

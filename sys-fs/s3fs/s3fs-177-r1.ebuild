# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/s3fs/s3fs-177-r1.ebuild,v 1.1 2009/06/21 15:42:30 caleb Exp $

MY_PV="r${PV}-source"

DESCRIPTION="Amazon mounting S3 via fuse"
HOMEPAGE="http://s3fs.googlecode.com/"
SRC_URI="http://s3fs.googlecode.com/files/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

DEPEND=">=net-misc/curl-7.17.1
	>=sys-fs/fuse-2.6.0
	dev-libs/libxml2
	dev-libs/openssl"

RDEPEND="${DEPEND}
	app-misc/mime-types"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin s3fs
}

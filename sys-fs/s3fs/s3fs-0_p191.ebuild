# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/s3fs/s3fs-0_p191.ebuild,v 1.2 2011/01/05 01:07:44 xmw Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_PV="r191-source"

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

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0_p177-asneeded.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die

}

src_install() {
	dobin s3fs || die
}

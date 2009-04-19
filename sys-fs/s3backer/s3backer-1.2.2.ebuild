# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/s3backer/s3backer-1.2.2.ebuild,v 1.1 2009/04/19 13:11:18 caleb Exp $

inherit eutils

DESCRIPTION="FUSE-based single file backing store via Amazon S3"
HOMEPAGE="http://code.google.com/p/s3backer"
SRC_URI="http://s3backer.googlecode.com/files/s3backer-${PV}.tar.gz"
LICENSE="GPL-2"
DEPEND="net-misc/curl
	sys-fs/fuse
	dev-libs/expat
	dev-libs/openssl"
RDEPEND="${DEPEND}"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

src_compile() {
	econf --prefix=/ --exec-prefix=/usr --localstatedir=/var || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}

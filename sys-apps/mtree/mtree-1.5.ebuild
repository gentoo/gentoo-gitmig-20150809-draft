# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mtree/mtree-1.5.ebuild,v 1.1 2003/09/09 13:12:30 tigger Exp $

DESCRIPTION="mtree is used to check the permissions of a file system against a spec file"
HOMEPAGE="http://www.netbsd.org/"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/packages/bootstrap-pkgsrc.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/bootstrap-pkgsrc

src_compile() {
	cd digest
	chmod +x configure
	econf
	emake || die
	cd ../mtree
	chmod +x configure
	econf
	emake || die
}

src_install() {
	cd mtree
	dosbin mtree
	doman mtree.8
}

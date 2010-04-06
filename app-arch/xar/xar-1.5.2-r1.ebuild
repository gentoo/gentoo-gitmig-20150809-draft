# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xar/xar-1.5.2-r1.ebuild,v 1.1 2010/04/06 22:33:03 spatz Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="an easily extensible archive format"
HOMEPAGE="http://code.google.com/p/xar"
SRC_URI="http://xar.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="acl +bzip2"

DEPEND="dev-libs/openssl
	dev-libs/libxml2
	sys-libs/zlib
	acl? ( sys-apps/acl )
	bzip2? ( app-arch/bzip2 )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-automagic_acl_and_bzip2.patch \
		"${FILESDIR}"/${P}-respect_ldflags.patch
	eautoconf
}

src_configure() {
	econf $(use_enable acl) $(use_enable bzip2)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc TODO
}

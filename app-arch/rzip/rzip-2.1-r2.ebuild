# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rzip/rzip-2.1-r2.ebuild,v 1.1 2010/01/17 19:30:05 bangert Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Compression program for large files"
HOMEPAGE="http://rzip.samba.org"
SRC_URI="http://rzip.samba.org/ftp/rzip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="app-arch/bzip2"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.1-darwin.patch
	epatch "${FILESDIR}"/${PN}-2.1-handle-broken-archive.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}

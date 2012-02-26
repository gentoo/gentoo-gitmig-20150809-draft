# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ext3grep/ext3grep-0.10.2.ebuild,v 1.3 2012/02/26 17:51:44 hanno Exp $

EAPI=3
inherit eutils

DESCRIPTION="Recover deleted files on an ext3 file system"
HOMEPAGE="http://code.google.com/p/ext3grep/"
SRC_URI="http://ext3grep.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug pch"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.10.1-gcc44.patch

	# Fix build against latest e2fsprogs, taken from
	# https://code.google.com/p/ext3grep/issues/detail?id=34
	epatch "${FILESDIR}"/${P}-new-e2fsprogs.diff
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable pch)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README || die
}

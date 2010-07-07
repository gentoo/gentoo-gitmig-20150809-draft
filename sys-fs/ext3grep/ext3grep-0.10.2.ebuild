# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ext3grep/ext3grep-0.10.2.ebuild,v 1.1 2010/07/07 21:43:01 hanno Exp $

EAPI=3

DESCRIPTION="Recover deleted files on an ext3 file system"
HOMEPAGE="http://code.google.com/p/ext3grep/"
SRC_URI="http://ext3grep.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug pch"
DEPEND=""

src_configure() {
	econf $(use_enable debug) \
		$(use_enable pch) || die "econd failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README || die
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/odt2txt/odt2txt-0.4.ebuild,v 1.2 2010/11/28 14:33:02 armin76 Exp $

EAPI=2

inherit eutils

DESCRIPTION="A simple converter from OpenDocument Text to plain text"
HOMEPAGE="http://stosberg.net/odt2txt/"
SRC_URI="http://stosberg.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86 ~x86-macos"
IUSE=""

RDEPEND="sys-libs/zlib
	virtual/libiconv"
DEPEND="sys-apps/groff
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-darwin_iconv.patch
}

src_install() {
	emake install DESTDIR="${D}" PREFIX=/usr || die
	doman odt2txt.1 || die
}

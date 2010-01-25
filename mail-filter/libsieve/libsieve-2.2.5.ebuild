# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libsieve/libsieve-2.2.5.ebuild,v 1.7 2010/01/25 19:28:58 bangert Exp $

inherit toolchain-funcs

DESCRIPTION="A library for parsing, sorting and filtering your mail."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libsieve.sourceforge.net/"

SLOT="0"
LICENSE="MIT LGPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="!<net-mail/mailutils-2.1"

src_compile() {
	cd "${S}"/src
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	cd "${S}"/src
	emake DESTDIR="${D}" install || die "emake install failed"
}

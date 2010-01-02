# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/o3read/o3read-0.0.4.ebuild,v 1.10 2010/01/02 11:30:59 fauli Exp $

inherit toolchain-funcs

DESCRIPTION="Converts OpenOffice formats to text or HTML."
HOMEPAGE="http://siag.nu/o3read/"
SRC_URI="http://siag.nu/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RESTRICT=test

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin o3read o3totxt o3tohtml utf8tolatin1 || die
	doman o3read.1 o3tohtml.1 o3totxt.1 utf8tolatin1.1 || die
}

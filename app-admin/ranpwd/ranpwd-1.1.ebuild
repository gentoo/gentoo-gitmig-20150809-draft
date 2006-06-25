# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ranpwd/ranpwd-1.1.ebuild,v 1.5 2006/06/25 19:34:49 blubb Exp $

DESCRIPTION="A program to generate random passwords using the in-kernel cryptographically secure random number generator.."
HOMEPAGE="http://ftp.lug.ro/kernel/software/utils/admin/ranpwd/"
SRC_URI="http://ftp.lug.ro/kernel/software/utils/admin/ranpwd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND=""

src_compile() {
	econf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make INSTALLROOT=${D} install || die
}

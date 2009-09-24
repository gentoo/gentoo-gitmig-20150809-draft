# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ranpwd/ranpwd-1.2.ebuild,v 1.3 2009/09/24 13:58:09 armin76 Exp $

DESCRIPTION="A program to generate random passwords using the in-kernel cryptographically secure random number generator.."
HOMEPAGE="http://ftp.lug.ro/kernel/software/utils/admin/ranpwd/"
SRC_URI="http://ftp.lug.ro/kernel/software/utils/admin/ranpwd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND=""

#src_compile() {
#	econf || die "./configure failed"
#	emake || die "emake failed"
#}

src_test() {
	einfo "generating random passwords"
	for a in 1 2 3 4 5 6 7 8 9
	do
		./ranpwd $(($a * 10))
	done
}

src_install() {
	make INSTALLROOT=${D} install || die
}

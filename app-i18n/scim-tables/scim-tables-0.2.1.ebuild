# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tables/scim-tables-0.2.1.ebuild,v 1.1 2003/05/25 15:10:52 liquidx Exp $

DESCRIPTION="Smart Common Input Method (SCIM) Generic Table Input Method Server"
HOMEPAGE="http://www.gnuchina.org/~suzhe/scim/"
SRC_URI="http://www.gnuchina.org/~suzhe/scim/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=app-i18n/scim-0.4.1"

S=${WORKDIR}/${P}

src_compile() {
	econf ${myconf}
	emake || "make failed"
}

src_install() {
	einstall || "install failed"
	dodoc README ChangeLog AUTHORS
}

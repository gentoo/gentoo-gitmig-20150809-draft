# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/yasr/yasr-0.6.5.ebuild,v 1.7 2004/05/31 18:45:21 vapier Exp $

DESCRIPTION="general-purpose console screen reader"
HOMEPAGE="http://yasr.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/glibc
	>=sys-devel/make-3.80
	>=sys-devel/autoconf-2.58"
RDEPEND=""

src_unpack(){
	unpack ${A}
	cd ${S}
	sed -i '/^aclocaldir =/s:@aclocaldir@:$(destdir)/aclocal:' ${S}/m4/Makefile.*
}

src_compile() {
	econf --datadir='/etc' || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog AUTHORS BUGS CREDITS INSTALL
}

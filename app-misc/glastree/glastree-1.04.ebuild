# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glastree/glastree-1.04.ebuild,v 1.1 2006/05/24 05:47:48 truedfx Exp $

inherit eutils

DESCRIPTION="glastree is a poor mans snapshot utility using hardlinks written in perl"
HOMEPAGE="http://www.igmus.org/code/"
SRC_URI="http://www.igmus.org/files/${P}.tar.gz"
DEPEND="dev-lang/perl
	dev-perl/Date-Calc"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
LICENSE="public-domain"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-posix-make.patch
}

src_install() {
	dodir /usr/share/man/man1
	make INSTROOT="${D}"/usr INSTMAN=share/man install || die
	dodoc README CHANGES THANKS TODO
}

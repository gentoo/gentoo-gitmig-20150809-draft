# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dclog/dclog-1.1.1.ebuild,v 1.2 2007/07/02 14:52:06 peper Exp $

DESCRIPTION="A logging library for C/C++ programs"
HOMEPAGE="http://sourceforge.net/projects/dclog/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
RESTRICT="mirror"

DEPEND=">=sys-devel/gcc-2.95"

src_compile() {
	make all
}

src_install() {
	make DESTDIR=${D} PREFIX=/usr install || die "install failed"
	dodoc VERSION
	dohtml docs/html/*
}

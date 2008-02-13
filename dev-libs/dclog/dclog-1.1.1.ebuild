# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dclog/dclog-1.1.1.ebuild,v 1.3 2008/02/13 08:26:35 opfer Exp $

DESCRIPTION="A logging library for C/C++ programs"
HOMEPAGE="http://sourceforge.net/projects/dclog/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
RESTRICT="mirror"

src_compile() {
	emake all
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "install failed"
	dodoc VERSION
	dohtml docs/html/*
}

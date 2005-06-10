# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/uisp/uisp-20050207.ebuild,v 1.1 2005/06/10 14:36:45 gustavoz Exp $

inherit eutils

DESCRIPTION="tool for AVR microcontrollers which can interface to many hardware in-system programmers"
HOMEPAGE="http://savannah.nongnu.org/projects/uisp"
SRC_URI="http://savannah.nongnu.org/download/uisp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-apps/gawk
	sys-devel/gcc"
RDEPEND=""

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
	dodoc doc/*
	prepalldocs
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/scope/scope-0.03.ebuild,v 1.1 2005/10/26 14:34:54 chrb Exp $

inherit eutils
DESCRIPTION="Serial Line Analyser"
HOMEPAGE="http://www.gumbley.me.uk/scope.html"
SRC_URI="http://www.gumbley.me.uk/scope-0.03.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"
S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ${S}/README
}

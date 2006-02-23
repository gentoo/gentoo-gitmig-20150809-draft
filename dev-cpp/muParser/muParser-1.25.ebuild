# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/muParser/muParser-1.25.ebuild,v 1.3 2006/02/23 13:59:32 caleb Exp $

inherit eutils

MY_PN=${PN/P/p}

DESCRIPTION="A fast math parser library"
HOMEPAGE="http://muparser.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "configuration failed"
	MAKEOPTS="$MAKEOPTS -j1" emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed!"
}

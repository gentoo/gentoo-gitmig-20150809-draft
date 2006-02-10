# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/muParser/muParser-1.25.ebuild,v 1.1 2006/02/10 13:43:57 caleb Exp $

inherit eutils

MY_PN=${PN/P/p}

DESCRIPTION="A fast math parser library"
HOMEPAGE="http://muparser.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed!"
}

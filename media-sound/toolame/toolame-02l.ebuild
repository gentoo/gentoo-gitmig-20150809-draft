# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/toolame/toolame-02l.ebuild,v 1.11 2004/09/15 17:40:35 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="tooLAME - an optimized mpeg 1/2 layer 2 audio encoder"
HOMEPAGE="http://www.planckenergy.com"
SRC_URI="mirror://sourceforge/toolame/${P}.tgz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 amd64"

DEPEND="virtual/libc
	sys-devel/gcc"

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff || die
	emake || die
}

src_install() {
	dobin toolame || die
	dodoc README HISTORY FUTURE html/* text/*
}



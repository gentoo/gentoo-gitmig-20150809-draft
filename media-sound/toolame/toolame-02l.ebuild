# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/toolame/toolame-02l.ebuild,v 1.17 2007/07/11 19:30:24 mr_bones_ Exp $

IUSE=""

inherit eutils

DESCRIPTION="tooLAME - an optimized mpeg 1/2 layer 2 audio encoder"
HOMEPAGE="http://www.planckenergy.com"
SRC_URI="mirror://sourceforge/toolame/${P}.tgz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc ~sparc x86"

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff
	emake || die
}

src_install() {
	dobin toolame || die
	dodoc README HISTORY FUTURE html/* text/*
}

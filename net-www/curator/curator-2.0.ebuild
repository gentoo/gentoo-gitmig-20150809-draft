# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/curator/curator-2.0.ebuild,v 1.10 2004/06/25 00:50:53 agriffis Exp $

MY_P=curator-2.0
S=${WORKDIR}/curator
SLOT="0"
DESCRIPTION="Webpage thumbnail creator"
SRC_URI="mirror://sourceforge/curator/${MY_P}.tar.gz"
HOMEPAGE="http://curator.sourceforge.net/"
KEYWORDS="x86 ~ppc ~sparc alpha ~mips amd64"
LICENSE="GPL-2"
DEPEND=">=dev-lang/python-2.2.1
		>=media-gfx/imagemagick-5.4.9"

src_install() {
	cd ${WORKDIR}
	dobin curator || die "install failed"
	dodoc CHANGES COPYING README
}


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/curator/curator-2.0.ebuild,v 1.2 2004/09/03 17:17:20 pvdabeel Exp $

MY_P=curator-2.0
DESCRIPTION="Webpage thumbnail creator"
HOMEPAGE="http://curator.sourceforge.net/"
SRC_URI="mirror://sourceforge/curator/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~mips amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.2.1
		>=media-gfx/imagemagick-5.4.9"

S="${WORKDIR}/curator"

src_install() {
	cd ${WORKDIR}
	dobin curator || die "install failed"
	dodoc CHANGES COPYING README
}


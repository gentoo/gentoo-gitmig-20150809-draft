# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/curator/curator-2.0.ebuild,v 1.3 2005/11/29 03:24:29 vapier Exp $

MY_P=curator-2.0
DESCRIPTION="Webpage thumbnail creator"
HOMEPAGE="http://curator.sourceforge.net/"
SRC_URI="mirror://sourceforge/curator/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~mips ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.1
	>=media-gfx/imagemagick-5.4.9"

S=${WORKDIR}/curator

src_install() {
	cd ${WORKDIR}
	dobin curator || die "install failed"
	dodoc CHANGES README
}

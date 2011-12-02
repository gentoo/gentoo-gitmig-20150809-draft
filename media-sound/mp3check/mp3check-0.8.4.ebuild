# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.4.ebuild,v 1.2 2011/12/02 19:19:27 beandog Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings."
HOMEPAGE="http://jo.ath.cx/soft/mp3check/index.html"
SRC_URI="http://jo.ath.cx/soft/mp3check/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_compile() {
	emake CXX="$(tc-getCXX)" OPT="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dobin mp3check || die "dobin failed"
}
